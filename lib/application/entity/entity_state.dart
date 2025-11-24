
import 'package:equatable/equatable.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';

abstract class EntityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EntityInitial extends EntityState {}

class GetTrackedEntityLoading extends EntityState {}

class GetTrackedEntityCompleted extends EntityState {



  List<TrackedEntity> trackedEntity=[];


  GetTrackedEntityCompleted({

    required this.trackedEntity,
  });

  @override
  List<Object?> get props => [trackedEntity];
}

class GetTrackedEntityError extends EntityState {
  final int code;
  final String? message;

  GetTrackedEntityError({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}