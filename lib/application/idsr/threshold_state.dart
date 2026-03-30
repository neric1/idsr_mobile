

import 'package:idsr/data/idsr/models/threshold_model.dart';

abstract class ThresholdState {}

class ThresholdInitial extends ThresholdState {}

class ThresholdLoading extends ThresholdState {}

class ThresholdLoaded extends ThresholdState {
  final ThresholdModel data;
  final String selectedDisease;
  final List filteredRows;

  ThresholdLoaded({
    required this.data,
    required this.selectedDisease,
    required this.filteredRows,
  });
}

class ThresholdError extends ThresholdState {
  final String message;

  ThresholdError(this.message);
}