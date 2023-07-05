part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostsInitalFetchEvent extends PostsEvent {}

class PostAddEvent extends PostsEvent {}
