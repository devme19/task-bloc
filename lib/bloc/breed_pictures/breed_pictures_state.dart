part of 'breed_pictures_bloc.dart';

@immutable
abstract class BreedPicturesState {}

class BreedPicturesInitial extends BreedPicturesState {}
class BreedPicturesLoading extends BreedPicturesState {}
class BreedPicturesLoaded extends BreedPicturesState {
  late final PictureModel data;
  BreedPicturesLoaded(this.data);
}
class BreedPicturesError extends BreedPicturesState {
  late final String errorMessage;
  BreedPicturesError(this.errorMessage);
}