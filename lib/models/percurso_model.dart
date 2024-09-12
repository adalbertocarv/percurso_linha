class PercursoModel {
  final List<List<double>> coordinates;
  final String sentido;
  final String codLinha;

  PercursoModel({
    required this.coordinates,
    required this.sentido,
    required this.codLinha,
  });

  factory PercursoModel.fromJson(Map<String, dynamic> json) {
    final feature = json['features'][0];
    final coordinates = List<List<double>>.from(
      feature['geometry']['coordinates'].map(
            (item) => List<double>.from(item),
      ),
    );
    return PercursoModel(
      coordinates: coordinates,
      sentido: feature['properties']['sentido'],
      codLinha: feature['properties']['codLinha'],
    );
  }
}
