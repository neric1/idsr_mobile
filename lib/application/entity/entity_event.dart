
import 'package:equatable/equatable.dart';

abstract class EntityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrackedEntityEvent extends EntityEvent {

  // GetTrackedEntityEvent({required this.parms,required this.searchRequest});

}


