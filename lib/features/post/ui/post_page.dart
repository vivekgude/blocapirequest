import 'package:blocapirequest/features/post/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    super.initState();
    postsBloc.add(PostsInitalFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts Page")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postsBloc.add(PostAddEvent());
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case PostsFetchingSuccessfulState:
              final successState = state as PostsFetchingSuccessfulState;
              return Container(
                child: ListView.builder(
                    itemCount: successState.posts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              successState.posts[index].title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(successState.posts[index].body),
                          ],
                        ),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                      );
                    }),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
