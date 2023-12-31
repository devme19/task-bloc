part of 'filter_by_breed_bloc.dart';

@immutable
abstract class FilterByBreedEvent {}
class FilterBreedEvent extends FilterByBreedEvent{
  String breed;
  List<String> items;
  FilterBreedEvent({required this.breed,required this.items});
}
class ClearFilterEvent extends FilterByBreedEvent{}

