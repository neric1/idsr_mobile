abstract class ThresholdEvent {}

class LoadThreshold extends ThresholdEvent {
  final String orgunit;
  final String period;

  LoadThreshold(this.orgunit, this.period);
}

class SelectDisease extends ThresholdEvent {
  final String diseaseId;

  SelectDisease(this.diseaseId);
}