part of 'like_image_bloc.dart';


abstract class LikeImageEvent {}
class LikedImageEvent extends LikeImageEvent{
  String? item;
  List<String>? likedItems;
  LikedImageEvent({this.item,this.likedItems});
}
class UnLikedImageEvent extends LikeImageEvent{
  String? item;
  List<String>? likedItems;

  UnLikedImageEvent({this.item, this.likedItems});
}
