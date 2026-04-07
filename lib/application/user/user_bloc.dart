
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/api/apiv2.dart';
import 'package:idsr/application/signals/signal_event.dart';
import 'package:idsr/application/signals/signal_state.dart';
import 'package:idsr/application/user/user_event.dart';
import 'package:idsr/application/user/user_state.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/data/entity/repository/entity_repository.dart';
import 'package:idsr/data/signals/models/user.dart';
import 'package:idsr/data/signals/repository/signals_repository.dart';
import 'package:idsr/session_hive.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final SignalsRepository signalsRepository;
  final ApiV2 appHttpClient;
  User? _user;
  User? get user => _user;
  UserBloc({required this.signalsRepository,required this.appHttpClient})
      : super(UserInitial()) {

    on<GetUserEvent>((event, emit) async {
      emit(GetUserLoading());



        final response = await signalsRepository.getUser(username:event.username,password:event.password);
      emit(response.fold(
              (error) {
            return GetUserError(
              code: error.errorCode!,
              message: error.errorMessage,
            );
          }, (success) {


        _user= User.fromJson(success.data);
        //
        // _trackedEntityAll=_trackedEntity;
        Session.saveUsername(event.username);
        Session.savePassword(event.password);
        appHttpClient.dio.options.headers['Authorization'] = 'Basic ${base64Encode(utf8.encode('${event.username}:${event.password}'))}';
        return GetUserCompleted(
          user: _user,
        );
      }));
    });
    on<LogoutEvent>((event, emit) async {
      appHttpClient.dio.options.headers['Authorization'] = '';

      Session.logout();
      emit(Loggedout());
    });
  }


}

