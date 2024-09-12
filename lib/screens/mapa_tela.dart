import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../config/map_config.dart';
import '../models/percurso_model.dart';
import '../utils/pesquisar_percurso.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController _controller = TextEditingController();
  PercursoModel? _percurso;
  List<LatLng> _polylinePoints = [];

  // Instância de PercursoPesquisa para chamar a função pesquisarPercurso
  final PercursoPesquisa _percursoPesquisa = PercursoPesquisa();

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
                  onPressed:
                      _onPesquisarPressed, // Usa a nova função _onPesquisarPressed
                ),
              ),
            ),
          ),
          Expanded(
            child: _percurso == null
                ? Center(child: Text('Pesquise uma linha de ônibus.'))
                : FlutterMap(
                    options: MapOptions(
                      center: _polylinePoints.isNotEmpty
                          ? _polylinePoints[0]
                          : LatLng(0, 0),
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

  // Função que será chamada ao pressionar o botão de pesquisa
  void _onPesquisarPressed() {
    _percursoPesquisa.pesquisarPercurso(
      linha: _controller.text,
      controller: _controller,
      context: context,
      onPercursoEncontrado: (percurso, polylinePoints) {
        setState(() {
          _percurso = percurso;
          _polylinePoints = polylinePoints;
        });
      },
    );
  }
}
