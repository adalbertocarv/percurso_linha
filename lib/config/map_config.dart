import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapConfig {
  static late MapOptions options;

  static const String tileLayerUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgentPackageName = 'dev.fleaflet.flutter_map.example';

  static TileLayer get tileLayer =>
      TileLayer(
        urlTemplate: tileLayerUrl,
        userAgentPackageName: userAgentPackageName,
        tileProvider: CancellableNetworkTileProvider(),
      );
}