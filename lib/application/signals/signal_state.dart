
import 'package:equatable/equatable.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

abstract class SignalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignalInitial extends SignalState {}

class GetTrackedSignalLoading extends SignalState {}

class GetTrackedSignalCompleted extends SignalState {



  List<TrackedEntity> trackedEntity=[];


  GetTrackedSignalCompleted({

    required this.trackedEntity,
  });

  @override
  List<Object?> get props => [trackedEntity];
}

class GetTrackedSignalError extends SignalState {
  final int code;
  final String? message;

  GetTrackedSignalError({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}