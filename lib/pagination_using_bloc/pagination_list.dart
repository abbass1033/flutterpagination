import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpagination/pagination/post_bloc.dart';

class PaginationList extends StatefulWidget {
  const PaginationList({Key? key}) : super(key: key);

  @override
  State<PaginationList> createState() => _PaginationListState();
}

class _PaginationListState extends State<PaginationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {

          if(state is PostLoadingState){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is PostSuccessfulState) {
            var posts = state.post;

            return ListView.builder(
              controller: context.read<PostBloc>().scrollController,
                itemCount:context.read<PostBloc>().isLoadingMore ? posts.length +1 : posts.length,
                itemBuilder: (context, index) {
                  if(index >= posts.length){
                    return Center(child: CircularProgressIndicator(),);

                  }
                  else{
                    var post = posts[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text("${index }"),),
                        title: Text(post['id'].toString()),
                        subtitle: Text(post['title']),

                      ),
                    );
                  }
            });
          }

          else{
            return SizedBox();
          }

        },
      ),
    );
  }
}
