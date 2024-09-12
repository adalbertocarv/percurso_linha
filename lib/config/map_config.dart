import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapConfig {
  static late MapOptions options;

  static const String tileLayerUrl = 'https://{s}.basemaps.cartocdn.com/{style}/{z}/{x}/{y}{r}.png';
  static const String userAgentPackageName = 'rastertiles/voyager_nolabels';

  static TileLayer get tileLayer => TileLayer(
    urlTemplate: tileLayerUrl,
    subdomains: ['a', 'b', 'c'],
    additionalOptions: {
      'style': userAgentPackageName, // Use 'rastertiles/dark_all' for dark mode
    },
    tileProvider: CancellableNetworkTileProvider(),
  );
}
