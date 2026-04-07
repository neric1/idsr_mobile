import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/application/user/user_state.dart';
import 'package:idsr/data/idsr/models/threshold_model.dart';
import 'package:idsr/data/idsr/repository/threshold_repository.dart';
import 'package:idsr/session_hive.dart';
import 'threshold_event.dart';
import 'threshold_state.dart';

class ThresholdBloc extends Bloc<ThresholdEvent, ThresholdState> {
  final ThresholdRepository repository;
  final UserBloc userBloc;
  late StreamSubscription userSubscription;
  String filter="";
  String orgUnit="";
  ThresholdBloc({required this.repository,required this.userBloc}) : super(ThresholdInitial()) {
    userSubscription = userBloc.stream.listen((authState) {
      if (authState is GetUserCompleted) {
        add(LoadThreshold(orgUnit,filter));
      }
    });
    on<LoadThreshold>((event, emit) async {
        filter=event.period;
        orgUnit=event.orgunit;
        print("object heree 00");
      if(!Session.isLoggedIn){
        print("object heree 11");
        return;}

        print("object heree 22");
      emit(ThresholdLoading());

      try {
        final response =
        await repository.fetchThreshold(period: event.period, orgunit: event.orgunit);
        emit(response.fold(
                (error) {
              return ThresholdError( error.errorMessage,
              );
            }, (success) {



          return ThresholdLoaded(
            data: ThresholdModel.fromJson(success.data),
            selectedDisease: "",
            filteredRows: [],
          );
        }));


      } catch (e) {
        emit(ThresholdError(e.toString()));
      }

    });

    on<SelectDisease>((event, emit) {

      if (state is ThresholdLoaded) {
        final current = state as ThresholdLoaded;

        // if (current.selectedDisease == event.diseaseId) {
        //   emit(ThresholdLoaded(
        //     data: current.data,
        //     selectedDisease: "",
        //     filteredRows: [],
        //   ));
        //   return;
        // }

        final rows = current.data.rows
            .where((r) => r[0] == event.diseaseId)
            .toList();

        emit(ThresholdLoaded(
          data: current.data,
          selectedDisease: event.diseaseId,
          filteredRows: rows,
        ));
      }
    });
  }
}