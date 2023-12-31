import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/repository/repository.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<GetFavouriteEvent, GetFavouriteState> {
  Repository? repository;
  FavouritesBloc({required this.repository}) : super(GetFavouritesInitial()) {
    on<GetFavouritesEvent>(mapGetFavouritesToEvent);
    on<InitialFavouriteEvent>(mapSetInitialFavouriteEvent);
  }
  mapGetFavouritesToEvent(GetFavouriteEvent event,Emitter emit)async{
    emit(GetFavouritesLoading());
    await Future.delayed(const Duration(seconds: 2));
    List<String> favourites = repository!.loadFavourites();
    emit(GetFavouritesLoaded(favourites: favourites));
  }
  mapSetInitialFavouriteEvent(GetFavouriteEvent event,Emitter emit){
   emit(GetFavouritesInitial());
  }
  List<String> loadBreeds(){
    return repository!.loadBreeds();
  }
}
