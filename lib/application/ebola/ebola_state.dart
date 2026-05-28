

import 'package:idsr/data/idsr/models/threshold_model.dart';

abstract class EbolaState {}

class EbolaInitial extends EbolaState {}

class EbolaLoading extends EbolaState {}

class EbolaLoaded extends EbolaState {
  final ThresholdModel data;
  final String selectedDisease;
  final List filteredRows;

  EbolaLoaded({
    required this.data,
    required this.selectedDisease,
    required this.filteredRows,
  });
}

class EbolaError extends EbolaState {
  final String message;

  EbolaError(this.message);
}