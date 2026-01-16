
import 'package:equatable/equatable.dart';

abstract class EntityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrackedEntityEvent extends EntityEvent {
  String programeId;
  bool filterLocal;
  String? countryId;
  GetTrackedEntityEvent({required this.programeId,this.filterLocal=false,this.countryId});

}


