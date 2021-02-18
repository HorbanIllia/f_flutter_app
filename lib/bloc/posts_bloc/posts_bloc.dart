import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:t_flutter_app/models/post.dart';
import 'package:t_flutter_app/util/api_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';


class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final ApiRepository _apiRepository = ApiRepository();

  PostsBloc() : super(null);

  @override
  PostsState get initialState => PostsInitial();

  @override
  Stream<PostsState> mapEventToState(
      PostsEvent event,
      ) async* {
    if (event is GetPostsList) {
      try {
        yield PostsLoading();
        final mList = await _apiRepository.fetchPostsList();
        yield PostsLoaded(mList);
        if (mList == null)
        {
          yield PostsError("error mapEvent");
        }
      } on NetworkError {
        yield PostsError("Failed to fetch data. Please check your internet connection");
      }
    }
  }
}