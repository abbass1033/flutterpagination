part of 'post_bloc.dart';

@immutable
abstract class PostEvent  {}

class FetchPostEvent extends PostEvent{}

class LoadMoreEvent extends PostEvent{

}
