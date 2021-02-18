part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  const PostsInitial();
  @override
  List<Object> get props => [];
}

class PostsLoading extends PostsState {
  const PostsLoading();
  @override
  List<Object> get props => null;
}

class PostsLoaded extends PostsState {
  final List<Post> postModel;
  const PostsLoaded(this.postModel);
  @override
  List<Object> get props => [postModel];
}

class PostsError extends PostsState {
  final String message;
  const PostsError(this.message);
  @override
  List<Object> get props => [message];
}