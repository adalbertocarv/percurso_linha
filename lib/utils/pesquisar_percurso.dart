import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/percurso_model.dart';
import '../services/percurso_service.dart';

class PercursoPesquisa {
  final PercursoService _percursoService = PercursoService();

  Future<void> pesquisarPercurso({
    required String linha,
    required TextEditingController controller,
    required BuildContext context,
    required Function(PercursoModel, List<LatLng>) onPercursoEncontrado,
  }) async {
    // Se o campo estiver vazio, não faz nada
    if (linha.isEmpty) return;

    try {
      // Chama o serviço para buscar o percurso da linha informada
      final percurso = await _percursoService.buscarPercurso(linha);

      // Converte as coordenadas retornadas pelo percurso para objetos LatLng
      final polylinePoints = percurso.coordinates
          .map((coord) => LatLng(coord[1],
              coord[0])) // Conversão das coordenadas [longitude, latitude]
          .toList();

      // Chama a função passada como callback para atualizar o estado
      onPercursoEncontrado(percurso, polylinePoints);
    } catch (e) {
      // Em caso de erro, exibe uma mensagem ao usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar o percurso: $e')),
      );
    }
  }
}