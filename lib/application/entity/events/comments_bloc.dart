import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idsr/application/entity/events/comments_event.dart';
import 'package:idsr/application/entity/events/comments_state.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/data/entity/repository/entity_repository.dart';


class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final EntityRepository repository;

  List<HumanitarianReport> _comments = [];
  List<HumanitarianReport> get comments => _comments;


  CommentBloc(this.repository) : super(CommentInitial()) {
    on<FetchComments>(_onFetchComments);
  }

  Future<void> _onFetchComments(
      FetchComments event,
      Emitter<CommentState> emit,
      ) async {
    emit(CommentLoading());

    final result = await repository.fetchComments();


    result.fold(
          (failure) => emit(CommentError(failure.errorMessage)),
          (comments) {
            _comments = comments.data;
            emit(CommentLoaded(comments.data));
          },
    );
  }
}