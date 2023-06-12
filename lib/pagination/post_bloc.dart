import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../repo/repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  PostRepo _repo;
  int page = 1;

  PostBloc(this._repo) : super(PostInitialState(null)) {

    scrollController.addListener(() {
      add(LoadMoreEvent());
    });
    on<FetchPostEvent>((event, emit) async{

      emit(PostLoadingState(null));

      var post = await _repo.fetchPost(page);
      emit(PostSuccessfulState(post: post));
      // TODO: implement event handler
    });

    on<LoadMoreEvent>((event, emit) async {

      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        isLoadingMore = true;
        page ++;

        var post = await _repo.fetchPost(page);
        emit(PostSuccessfulState(post: [...state.post , post]));
      }
    });
  }
}
