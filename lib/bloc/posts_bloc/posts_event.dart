part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class GetPostsList extends PostsEvent {
  @override
  List<Object> get props => null;
}