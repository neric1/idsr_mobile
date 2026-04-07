
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends UserEvent {
String username;
String password;
GetUserEvent({required this.username, required this.password});
}

class LogoutEvent extends UserEvent {}



