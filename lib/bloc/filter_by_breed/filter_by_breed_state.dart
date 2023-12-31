part of 'filter_by_breed_bloc.dart';

@immutable
abstract class FilterByBreedState {
  String? breed;
  FilterByBreedState({this.breed});
}

class FilterByBreedInitial extends FilterByBreedState {}
class FilterByBreedLoaded extends FilterByBreedState {
  List<String> filteredItems;
  FilterByBreedLoaded({required this.filteredItems,breed}):super(breed: breed);
}
class FilterByBreedEmpty extends FilterByBreedState{
  FilterByBreedEmpty({breed}):super(breed: breed);
}
class ClearFilter extends FilterByBreedState{}
