abstract class DiseaseEvent {}

class FetchDiseaseTrend extends DiseaseEvent {
  final String period;
  final String disease;
  final String country;

  FetchDiseaseTrend({
    required this.period,
    required this.disease,
    required this.country
  });
}