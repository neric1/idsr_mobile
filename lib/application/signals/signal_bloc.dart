
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/signals/signal_event.dart';
import 'package:idsr/application/signals/signal_state.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/application/user/user_state.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/data/entity/repository/entity_repository.dart';
import 'package:idsr/data/signals/repository/signals_repository.dart';


class SignalBloc extends Bloc<SignalEvent, SignalState> {
  final SignalsRepository signalsRepository;

  final UserBloc userBloc;
  List<TrackedEntity> _trackedEntity=[];
  List<TrackedEntity> get trackedEntity => _trackedEntity;
  List<TrackedEntity> _trackedEntityAll=[];

  late StreamSubscription userSubscription;
  SignalBloc({required this.signalsRepository,required this.userBloc})
      : super(SignalInitial()) {
    userSubscription = userBloc.stream.listen((authState) {
      if (authState is GetUserCompleted) {
        add(GetTrackedSignalEvent(programeId: 'E12ZY36aT08&attribute=Zhmz8B6mqEx:GE:2017-01-07:LE:null'));
      }
    });
    on<GetTrackedSignalEvent>((event, emit) async {
      emit(GetTrackedSignalLoading());

      if(event.filterLocal){
        await Future.delayed(const Duration(seconds: 1));
        if(event.countryId!="0"){
          final filteredInstances = _trackedEntityAll.where((instance) {
            // safely get orgUnit from enrollments
            if (instance.enrollments.isEmpty) return false;

            final orgUnitId = instance.enrollments[0].orgUnit as String?;
            return orgUnitId != null && orgUnitId == event.countryId;
          }).toList();
          _trackedEntity=filteredInstances;
          emit(GetTrackedSignalCompleted(
            trackedEntity: filteredInstances,
          ));
        }else{
          _trackedEntity=_trackedEntityAll;
          emit(GetTrackedSignalCompleted(
            trackedEntity: _trackedEntity,
          ));
        }

      }else{

        final response = await signalsRepository.getTrackedEntity(programeId:event.programeId);
      emit(response.fold(
              (error) {
            return GetTrackedSignalError(
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

        _trackedEntityAll=_trackedEntity;

        return GetTrackedSignalCompleted(
          trackedEntity: _trackedEntity,
        );
      }));}
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