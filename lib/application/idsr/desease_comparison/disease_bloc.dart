import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/idsr/desease_comparison/disease_event.dart';
import 'package:idsr/application/idsr/desease_comparison/disease_state.dart';
import 'package:idsr/application/user/user_bloc.dart';
import 'package:idsr/application/user/user_state.dart';
import 'package:idsr/data/idsr/models/disease_model.dart';
import 'package:idsr/data/idsr/models/threshold_model.dart';
import 'package:idsr/data/idsr/repository/threshold_repository.dart';
import 'package:idsr/session_hive.dart';
import 'package:idsr/utils/constant.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  final ThresholdRepository repository;
  final UserBloc userBloc;
  late StreamSubscription userSubscription;

  String orgUnit="";
  String disease="";
  String _period="";

  String get period => _period;

  DiseaseBloc({required this.repository,required this.userBloc}) : super(DiseaseInitial()) {
    userSubscription = userBloc.stream.listen((authState) {
      if (authState is GetUserCompleted) {
        add(FetchDiseaseTrend( period: period, disease: disease, country: orgUnit));
      }
    });
    on<FetchDiseaseTrend>(_onFetch);
  }

  Future<void> _onFetch(
      FetchDiseaseTrend event,
      Emitter<DiseaseState> emit,
      ) async {
    _period=event.period;
    orgUnit=event.country;
    disease=event.disease;
    // print("object heree 00");
    if(!Session.isLoggedIn){
      // print("object heree 11");
      return;}
    emit(DiseaseLoading());


      try {
        final response =
        await repository.fetchDiseaseTrends(
            period: event.period,
            disease: event.disease,
            orgunit: event.country);
        emit(response.fold(
                (error) {
              return DiseaseError( error.errorMessage,
              );
            }, (success) {



          return DiseaseLoaded(
             prodocesData(data: ThresholdModel.fromJson(success.data)),
            dataDefaultFiltered: prodocesDataDefaultFiltered(data: ThresholdModel.fromJson(success.data)),
          );
        }));

      // emit(DiseaseLoaded(data));
    } catch (e) {
      emit(DiseaseError(e.toString()));
    }
  }

}

  List<DiseaseTrend> prodocesData({
    required ThresholdModel data,
  })  {



    var cpe = data.metaData['dimensions']['pe'];
    var dx = data.metaData['dimensions']['dx'];
    var items = data.metaData['items'];
    var dataV = data.rows;


    final cWeek = cpe[0];
    final pWeek = cpe[1];



    List<DiseaseTrend> realData = [];

    for (var del in dx) {
      final currentData =
      dataV.where((d) => d[0] == del && d[1] == cWeek).toList();


      final previousData =
      dataV.where((d) => d[0] == del && d[1] == pWeek).toList();


      int currCase =
      currentData.isNotEmpty ? int.parse(currentData[0][4]) : 0;

      int prevCase =
      previousData.isNotEmpty ? int.parse(previousData[0][4]) : 0;

      double percentage = prevCase != 0
          ? ((currCase - prevCase) / prevCase) * 100
          : (currCase > 0 ? 100 : 0);

      realData.add(DiseaseTrend(
        name: items[del]['name'].split("|")[1],
        value: currCase,
        previous: prevCase,
        percentage: double.parse(percentage.toStringAsFixed(1)),
      ));
    }

    realData.sort((a, b) {
      // if (a.percentage == 0 && b.percentage == 0) return 0;
      // if (a.percentage == 0) return 1;
      // if (b.percentage == 0) return -1;
      return b.percentage.compareTo(a.percentage);
    });

    return realData;
  }
List<DiseaseTrend> prodocesDataDefaultFiltered({
  required ThresholdModel data,
})  {



  var cpe = data.metaData['dimensions']['pe'];
  var dx = data.metaData['dimensions']['dx'];
  var items = data.metaData['items'];
  var dataV = data.rows;


  final cWeek = cpe[0];
  final pWeek = cpe[1];



  List<DiseaseTrend> realData = [];
final ddx=dx.where((element) => defaultDeseaseCompare().split(";").contains(element)).toList();
  for (var del in ddx) {
    final currentData =
    dataV.where((d) => d[0] == del && d[1] == cWeek).toList();


    final previousData =
    dataV.where((d) => d[0] == del && d[1] == pWeek).toList();


    int currCase =
    currentData.isNotEmpty ? int.parse(currentData[0][4]) : 0;

    int prevCase =
    previousData.isNotEmpty ? int.parse(previousData[0][4]) : 0;

    double percentage = prevCase != 0
        ? ((currCase - prevCase) / prevCase) * 100
        : (currCase > 0 ? 100 : 0);

    realData.add(DiseaseTrend(
      name: items[del]['name'].split("|")[1],
      value: currCase,
      previous: prevCase,
      percentage: double.parse(percentage.toStringAsFixed(1)),
    ));
  }

  realData.sort((a, b) {
    // if (a.percentage == 0 && b.percentage == 0) return 0;
    // if (a.percentage == 0) return 1;
    // if (b.percentage == 0) return -1;
    return b.percentage.compareTo(a.percentage);
  });

  return realData;
}