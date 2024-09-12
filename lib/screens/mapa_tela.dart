import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../config/map_config.dart';
import '../models/percurso_model.dart';
import '../services/percurso_service.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController _controller = TextEditingController();
  final PercursoService _percursoService = PercursoService();
  PercursoModel? _percurso;
  List<LatLng> _polylinePoints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Ônibus'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite o número da linha',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _pesquisarPercurso,
                ),
              ),
            ),
          ),
          Expanded(
            child: _percurso == null
                ? Center(child: Text('Pesquise uma linha de ônibus.'))
                : FlutterMap(
              options: MapOptions(
                center: _polylinePoints.isNotEmpty ? _polylinePoints[0] : LatLng(0, 0),
                zoom: 13.0,
              ),
              children: [
                MapConfig.tileLayer,
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _polylinePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pesquisarPercurso() async {
    final linha = _controller.text;
    if (linha.isEmpty) return;

    try {
      final percurso = await _percursoService.buscarPercurso(linha);
      setState(() {
        _percurso = percurso;
        _polylinePoints = percurso.coordinates
            .map((coord) => LatLng(coord[1], coord[0]))
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar o percurso: $e')),
      );
    }
  }
}
