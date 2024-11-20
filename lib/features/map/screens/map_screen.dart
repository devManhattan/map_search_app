import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_konsi/core/endpoints.dart';
import 'package:test_konsi/core/messages.dart';
import 'package:test_konsi/features/map/bloc/map/map_bloc.dart';
import 'package:test_konsi/features/map/bloc/recent_searches/recent_searches_bloc.dart';
import 'package:test_konsi/features/map/widgets/bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey bottomSheetKey = GlobalKey();
  late MapBloc mapBloc;
  TextEditingController fieldText = TextEditingController();
  late RecentSearchesBloc recentSearchesBloc;
  FocusNode field = FocusNode();
  @override
  void initState() {
    super.initState();
    mapBloc = GetIt.I.get<MapBloc>();
    recentSearchesBloc = GetIt.I.get<RecentSearchesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: field.hasFocus
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (fieldText.text.isEmpty || fieldText.text.length != 8) {
                      scaffoldMensegerError(
                          'O cep não foi preenchido corretamente', context);
                      return;
                    }
                    field.unfocus();
                    setState(() {});
                    mapBloc.add(MapSearchEvent(cep: fieldText.text));
                  },
                  child:const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              const  SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    fieldText.clear();
                    field.unfocus();
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: mapBloc),
          BlocProvider.value(value: recentSearchesBloc),
        ],
        child: BlocConsumer<MapBloc, MapState>(
          listener: (context, state) {
            if (state is MapError) {
              scaffoldMensegerError(
                  "Não foi possível localizar o endereço", context);
            }
            if (state is MapLoaded) {
              showBottomSheet(
                  showDragHandle: true,
                  enableDrag: true,
                  context: context,
                  builder: (context) {
                    return BottomSheetLocation(
                        key: bottomSheetKey, location: state.location);
                  });
            }
          },
          builder: (context, state) {
            if (state is MapLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: state is MapLoaded
                        ? state.latLng
                        : const LatLng(-12.97304, -38.50230),
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: Endpoints.mapUrlTemplate,
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    state is MapLoaded
                        ? MarkerLayer(markers: [
                            Marker(
                                point: state.latLng,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red[400],
                                ))
                          ])
                        : const SizedBox.shrink(),
                  ],
                ),
                field.hasFocus
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.white,
                      )
                    : const SizedBox.shrink(),
                Positioned(
                  top: 50.0,
                  left: 10.0,
                  right: 10.0,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          keyboardType: TextInputType.number,
                          controller: fieldText,
                          onTap: () async {
                            if (bottomSheetKey.currentContext != null &&
                                bottomSheetKey.currentContext!.mounted) {
                              Navigator.pop(context);
                            }
                            await Future.delayed(Duration.zero);
                            recentSearchesBloc.add(GetRecentSearchesEvent());
                            setState(() {});
                          },
                          focusNode: field,
                          decoration: const InputDecoration(
                            hintText: 'Buscar',
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),
                      field.hasFocus
                          ? BlocBuilder<RecentSearchesBloc,
                              RecentSearchesState>(
                              builder: (context, state) {
                                if (state is RecentSearchesLoaded) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (int recentsCount = 0;
                                            recentsCount <
                                                state.locations.length;
                                            recentsCount++)
                                          Column(
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  mapBloc.add(MapSearchEvent(
                                                      cep: state
                                                          .locations[
                                                              recentsCount]
                                                          .cep));
                                                  field.unfocus();
                                                  setState(() {});
                                                },
                                                leading: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                title: Text(
                                                  state.locations[recentsCount]
                                                      .cep,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                subtitle: Text(
                                                    "${state.locations[recentsCount].logradouro} - ${state.locations[recentsCount].bairro} "),
                                              ),
                                           const   Divider()
                                            ],
                                          )
                                      ],
                                    ),
                                  );
                                }
                                if (state is RecentSearchesError) {
                                  return const Icon(Icons.error);
                                }

                                return const CircularProgressIndicator();
                              },
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
