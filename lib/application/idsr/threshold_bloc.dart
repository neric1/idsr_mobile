import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/data/idsr/models/threshold_model.dart';
import 'package:idsr/data/idsr/repository/threshold_repository.dart';
import 'threshold_event.dart';
import 'threshold_state.dart';

class ThresholdBloc extends Bloc<ThresholdEvent, ThresholdState> {
  final ThresholdRepository repository;

  ThresholdBloc({required this.repository}) : super(ThresholdInitial()) {

    on<LoadThreshold>((event, emit) async {
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