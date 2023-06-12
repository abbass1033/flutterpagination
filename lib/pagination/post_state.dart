part of 'post_bloc.dart';

@immutable
abstract class PostState {
  final post ;
  PostState(this.post);

}

class PostInitialState extends PostState {
  PostInitialState(super.post);
}

class PostLoadingState extends PostState{
  PostLoadingState(super.post);

}

class PostSuccessfulState  extends PostState{
  PostSuccessfulState({required post}) : super(post);

}
