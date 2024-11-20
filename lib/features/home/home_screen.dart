import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_konsi/features/favorites/bloc/list_favorites/list_favorites_bloc.dart';
import 'package:test_konsi/features/favorites/screens/favorites_screen.dart';
import 'package:test_konsi/features/map/screens/map_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  void updateFavorites(int index) {
    if (index == 1) {
      ListFavoritesBloc listFavoritesBloc = GetIt.I.get<ListFavoritesBloc>();
      listFavoritesBloc.add(ExecuteListFavoritesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: [
          const MapScreen(),
          FavoritesScreen(
            callbackOnChangeLocationNavigation: () {
              pageIndex = 0;
              setState(() {});
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: (index) {
            updateFavorites(index);
            pageIndex = index;
            setState(() {});
          },
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/mapa.png',
                  height: 40,
                  color: pageIndex == 0 ? Theme.of(context).primaryColor : null,
                ),
                label: 'Mapa'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/caderneta.png',
                    height: 40,
                    color:
                        pageIndex == 1 ? Theme.of(context).primaryColor : null),
                label: 'Caderneta'),
          ]),
    );
  }
}
