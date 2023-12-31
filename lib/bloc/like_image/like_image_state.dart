part of 'like_image_bloc.dart';

abstract class LikeImageState {}

class LikeImageInitial extends LikeImageState {}
class LikedImageState extends LikeImageState {
  List<String>? likedItems;
  LikedImageState({this.likedItems});
}
