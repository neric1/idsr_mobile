
import 'package:equatable/equatable.dart';

abstract class SignalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrackedSignalEvent extends SignalEvent {
String programeId;
  GetTrackedSignalEvent({required this.programeId});

}


