part of 'breed_pictures_bloc.dart';

@immutable
abstract class BreedPicturesEvent {}

class FetchBreedPicturesEvent extends BreedPicturesEvent{
  String breed;
  FetchBreedPicturesEvent({required this.breed});
}
