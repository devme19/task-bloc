import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/repository/repository.dart';

part 'filter_by_breed_event.dart';
part 'filter_by_breed_state.dart';

class FilterByBreedBloc extends Bloc<FilterByBreedEvent, FilterByBreedState> {
  Repository? repository;
  FilterByBreedBloc({required this.repository}) : super(FilterByBreedInitial()) {
    on<FilterBreedEvent>(mapFilterByBreedEventToState);
    on<ClearFilterEvent>(mapClearFilterEventToState);
  }
  mapFilterByBreedEventToState(FilterBreedEvent event, Emitter emit){
    List<String> breeds =event.items;
    String filter = event.breed;
    List<String> filteredItems=[];
    for(String item in breeds){
      if(item.contains(filter)){
        filteredItems.add(item);
      }
    }
    if(filteredItems.isEmpty){
      emit(FilterByBreedEmpty(breed: filter));
    }
    else{
      emit(FilterByBreedLoaded(filteredItems: filteredItems,breed: filter));
    }
  }
  mapClearFilterEventToState(ClearFilterEvent event,Emitter emit){
    emit(ClearFilter());
  }
  List<String> loadBreeds(){
    return repository!.loadBreeds();
  }
}
