
import 'package:equatable/equatable.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/data/signals/models/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class GetUserLoading extends UserState {}

class GetUserCompleted extends UserState {



  User? user;


  GetUserCompleted({

    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class GetUserError extends UserState {
  final int code;
  final String? message;

  GetUserError({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}
class Loggedout extends UserState {}