import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapConfig {
  static late MapOptions options;
  static LatLng? userLocation;

  static Future<void> inicializar() async {
    // Define coordenadas padrão caso a localização do usuário não esteja disponível
    const LatLng coordenadasPadrao = LatLng(-15.794091, -47.882742);


    // Inicializa as opções do mapa com a localização obtida ou padrão
    options = MapOptions(
      initialCenter: userLocation ?? coordenadasPadrao,
      // Usa a localização do usuário ou as coordenadas padrão
      initialZoom: 16,
      interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
    );
  }

  static const String tileLayerUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgentPackageName = 'dev.fleaflet.flutter_map.example';

  static TileLayer get tileLayer =>
      TileLayer(
        urlTemplate: tileLayerUrl,
        userAgentPackageName: userAgentPackageName,
        tileProvider: CancellableNetworkTileProvider(),
      );
}