import 'package:test_konsi/core/injector.dart';
import 'package:test_konsi/features/favorites/di.dart';
import 'package:test_konsi/features/map/di.dart';

class AppInjector extends Injector {
  @override
  Future<void> inject() async {
   await MapInjector().inject();
   await FavoritesInjector().inject();
  }
}
