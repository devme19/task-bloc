part of 'favourites_bloc.dart';

@immutable
abstract class GetFavouriteEvent {}

class GetFavouritesEvent extends GetFavouriteEvent{}
class InitialFavouriteEvent extends GetFavouriteEvent{}
