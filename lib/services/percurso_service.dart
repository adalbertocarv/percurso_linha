import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/percurso_model.dart';

class PercursoService {
  final String baseUrl = 'https://www.sistemas.dftrans.df.gov.br/percurso/linha/numero/';

  Future<PercursoModel> buscarPercurso(String linha) async {
    final response = await http.get(Uri.parse('$baseUrl$linha/WGS'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PercursoModel.fromJson(data);
    } else {
      throw Exception('Erro ao buscar percurso');
    }
  }
}
