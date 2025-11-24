
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/entity/entity_event.dart';
import 'package:idsr/application/entity/entity_state.dart';
import 'package:idsr/data/entity/models/repository/entity_repository.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';


class EntityBloc extends Bloc<EntityEvent, EntityState> {
  final EntityRepository entityRepository;

  List<TrackedEntity> _trackedEntity=[];
  List<TrackedEntity> get trackedEntity => _trackedEntity;

  EntityBloc({required this.entityRepository})
      : super(EntityInitial()) {

    on<GetTrackedEntityEvent>((event, emit) async {
      emit(GetTrackedEntityLoading());
      final response = await entityRepository.getTrackedEntity();
      emit(response.fold(
              (error) {
            return GetTrackedEntityError(
              code: error.errorCode!,
              message: error.errorMessage,
            );
          }, (success) {

        // final newTeams = safeConvertList(success.data).map((team)=>Team.fromJson(team)).toList();
        // print('TeamBloc: Loaded ${newTeams.length} teams, page: ${params.page}, hasMoreTeams: $_hasMoreTeams');
        //
        // // If it's the first page (page 1), replace the list
        // if (params.page == 1 || params.page == null) {
        //   _teams = newTeams;
        // } else {
        //   // For subsequent pages, append to the existing list
        //   _teams.addAll(newTeams);
        // }
        //
        // // Check if we have more teams (if we got less than perPage, we're at the end)
        // _hasMoreTeams = newTeams.length >= 100;
        _trackedEntity= safeConvertList(success.data["trackedEntityInstances"]).map((team)=>TrackedEntity.fromJson(team)).toList();



        return GetTrackedEntityCompleted(
          trackedEntity: _trackedEntity,
        );
      }));
    });

  }


}

List<Map<String, dynamic>> safeConvertList(dynamic jsonList) {
  if (jsonList is List) {
    return jsonList
        .whereType<Map<String, dynamic>>() // Filters out non-maps
        .toList();
  }
  return []; // Return an empty list if it's not a valid list
}