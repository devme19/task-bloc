part of 'list_of_dog_breeds_bloc.dart';

@immutable
abstract class ListOfDogBreedsState {}

class ListOfDogBreedsInitial extends ListOfDogBreedsState {}
class ListOfDogBreedsLoading extends ListOfDogBreedsState {}
class ListOfDogBreedsLoaded extends ListOfDogBreedsState {
  late final AllBreedsModel data;
  ListOfDogBreedsLoaded(this.data);
}
class ListOfDogBreedsError extends ListOfDogBreedsState {
  late final String errorMessage;
  ListOfDogBreedsError(this.errorMessage);
}