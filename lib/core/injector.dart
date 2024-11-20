import 'package:get_it/get_it.dart';

abstract class Injector {
  final i = GetIt.instance;
  Future<void> inject();
}
