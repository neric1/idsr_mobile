import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/ebola/ebola_event.dart';
import 'package:idsr/application/ebola/ebola_state.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/application/user/user_state.dart';
import 'package:idsr/data/idsr/models/threshold_model.dart';
import 'package:idsr/data/idsr/repository/threshold_repository.dart';
import 'package:idsr/session_hive.dart';

class EbolaBloc extends Bloc<EbolaEvent, EbolaState> {
  final ThresholdRepository repository;
  final UserBloc userBloc;
  late StreamSubscription userSubscription;
  String filter="";
  String orgUnit="";
  EbolaBloc({required this.repository,required this.userBloc}) : super(EbolaInitial()) {
    userSubscription = userBloc.stream.listen((authState) {
      if (authState is GetUserCompleted) {
        add(LoadEbola(orgUnit,filter));
      }
    });
    on<LoadEbola>((event, emit) async {
        filter=event.period;
        orgUnit=event.orgunit;
        // print("object heree 00");
      if(!Session.isLoggedIn){
        // print("object heree 11");
        return;}

        // print("object heree 22");
      emit(EbolaLoading());

      try {
        final response =
        await repository.fetchEbola(period: event.period, orgunit: event.orgunit);
        emit(response.fold(
                (error) {
              return EbolaError( error.errorMessage,
              );
            }, (success) {



          return EbolaLoaded(
            data: ThresholdModel.fromJson(success.data),
            selectedDisease: "",
            filteredRows: [],
          );
        }));


      } catch (e) {
        emit(EbolaError(e.toString()));
      }

    });

  }
}