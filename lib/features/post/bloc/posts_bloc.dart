import 'dart:async';
import 'package:blocapirequest/features/post/models/data_ui_models.dart';

import 'package:bloc/bloc.dart';
import 'package:blocapirequest/features/post/repos/posts_repo.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitalFetchEvent>(postsInitalFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitalFetchEvent(
      PostsInitalFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
    emit(PostsFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();
    print(success);
    if (success) {
      emit(PostAdditionSuccessState());
    } else {
      emit(PostAdditionErrorState());
    }
  }
}
