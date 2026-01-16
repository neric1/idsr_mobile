
import 'package:equatable/equatable.dart';

abstract class SignalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrackedSignalEvent extends SignalEvent {
String programeId;
bool filterLocal;
String? countryId;
  GetTrackedSignalEvent({required this.programeId,this.filterLocal=false,this.countryId});

}


