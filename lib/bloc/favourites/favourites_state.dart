part of 'favourites_bloc.dart';

@immutable
abstract class GetFavouriteState {}

class GetFavouritesInitial extends GetFavouriteState {}
class GetFavouritesLoading extends GetFavouriteState {}
class GetFavouritesError extends GetFavouriteState {}
class GetFavouritesLoaded extends GetFavouriteState {
  late List<String> favourites;
  GetFavouritesLoaded({required this.favourites});
}
