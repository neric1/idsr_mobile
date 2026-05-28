abstract class EbolaEvent {}

class LoadEbola extends EbolaEvent {
  final String orgunit;
  final String period;

  LoadEbola(this.orgunit, this.period);
}
