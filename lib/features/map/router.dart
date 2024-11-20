import 'package:go_router/go_router.dart';
import 'package:test_konsi/global/models/location.dart';
import 'package:test_konsi/features/map/screens/revision_screen.dart';

extension FullPath on MapRoutesEnum {
  String get fullPath => '${MapRouter.basePath}/$routePath';
}

enum MapRoutesEnum {
  revision('revision', 'revision');

  const MapRoutesEnum(
    this.routePath,
    this.routeName,
  );

  final String routePath;
  final String routeName;
}

class MapRouter {
  MapRouter._();

  static const basePath = '/map';

  static List<RouteBase> routes = [
    GoRoute(
      path: MapRoutesEnum.revision.fullPath,
      builder: (context, state) => RevisionScreen(
        location: state.extra as Location,
      ),
    ),
  ];
}
