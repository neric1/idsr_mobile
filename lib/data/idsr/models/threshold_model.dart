class ThresholdModel {
  final Map<String, dynamic> metaData;
  final List rows;

  ThresholdModel({
    required this.metaData,
    required this.rows,
  });

  factory ThresholdModel.fromJson(Map<String, dynamic> json) {
    return ThresholdModel(
      metaData: json['metaData'] ?? {},
      rows: json['rows'] ?? [],
    );
  }
}