import 'package:idsr/data/idsr/models/disease_model.dart';

abstract class DiseaseState {}

class DiseaseInitial extends DiseaseState {}

class DiseaseLoading extends DiseaseState {}

class DiseaseLoaded extends DiseaseState {
  final List<DiseaseTrend> data;
  final List<DiseaseTrend> dataDefaultFiltered;

  DiseaseLoaded(this.data,{this.dataDefaultFiltered=const []});
}

class DiseaseError extends DiseaseState {
  final String message;

  DiseaseError(this.message);
}