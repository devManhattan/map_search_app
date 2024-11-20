import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_konsi/core/messages.dart';
import 'package:test_konsi/features/favorites/bloc/list_favorites/list_favorites_bloc.dart';
import 'package:test_konsi/features/map/bloc/map/map_bloc.dart';
import 'package:test_konsi/global/models/location.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen(
      {super.key, required this.callbackOnChangeLocationNavigation});
  final Function callbackOnChangeLocationNavigation;
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late ListFavoritesBloc listFavoritesBloc;
  List<Location> locationMainList = [];
  List<Location> locationListing = [];
  TextEditingController searchFieldText = TextEditingController();
  late MapBloc mapBloc;
  @override
  void initState() {
    super.initState();
    mapBloc = GetIt.I.get<MapBloc>();
    listFavoritesBloc = GetIt.I.get<ListFavoritesBloc>();
    listFavoritesBloc.add(ExecuteListFavoritesEvent());
    searchFieldText.addListener(clearFilters);
  }

  void clearFilters() {
    if (searchFieldText.text.isEmpty) {
      locationListing = locationMainList;
    }
  }

  void filterLocations(String searchParm) {
    List<Location> locationsFiltered = locationMainList
        .where((element) =>
            element.cep.contains(searchParm) ||
            element.logradouro
                .toLowerCase()
                .contains(searchParm.toLowerCase()) ||
            element.bairro.toLowerCase().contains(searchParm.toLowerCase()))
        .toList();
    locationListing = locationsFiltered;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: searchFieldText.text.isNotEmpty
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  filterLocations(searchFieldText.text);
                },
                child: const Icon(Icons.search),
              )
            : null,
        body: BlocProvider.value(
          value: listFavoritesBloc,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return BlocConsumer<ListFavoritesBloc, ListFavoritesState>(
                listener: (context, state) {
                  if (state is ListFavoritesLoaded) {
                    locationMainList = state.locations;
                    locationListing = locationMainList;
                  }
                },
                builder: (context, state) {
                  if (state is ListFavoritesLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: searchFieldText,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Buscar',
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    icon:
                                        Icon(Icons.search, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (locationListing.isEmpty)
                            const Center(
                              child: Text("Nenhum endereço salvo"),
                            ),
                          for (int countFavorites = 0;
                              countFavorites < locationListing.length;
                              countFavorites++)
                            Column(
                              children: [
                                ListTile(
                                  onLongPress: () {
                                    dialogConfirmAction(
                                        "Deseja deletar esse endereço?", () {
                                      listFavoritesBloc.add(
                                          DeleteListFavoritesEvent(
                                              id: locationListing[
                                                      countFavorites]
                                                  .id!));
                                      Navigator.pop(context);
                                    }, context);
                                  },
                                  onTap: () {
                                    mapBloc.add(MapSearchEvent(
                                        cep: locationListing[countFavorites]
                                            .cep));
                                    widget.callbackOnChangeLocationNavigation();
                                  },
                                  trailing: Icon(
                                    Icons.bookmark,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: Text(
                                    locationListing[countFavorites].cep,
                                    style:
                                       const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                      "${locationListing[countFavorites].logradouro} - ${locationListing[countFavorites].bairro} "),
                                ),
                                const Divider()
                              ],
                            ),
                        ],
                      ),
                    );
                  }
                  if (state is ListFavoritesError) {
                    return const Center(child: Icon(Icons.error));
                  }
                  return const CircularProgressIndicator();
                },
              );
            }),
          )),
        ));
  }
}
