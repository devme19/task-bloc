import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/data/models/picture_model.dart';
import 'package:task/repository/repository.dart';

part 'breed_pictures_event.dart';
part 'breed_pictures_state.dart';

class BreedPicturesBloc extends Bloc<BreedPicturesEvent, BreedPicturesState> {
  Repository repository;
  BreedPicturesBloc({required this.repository}) : super(BreedPicturesInitial()) {
    on<FetchBreedPicturesEvent>((event, emit) async{
        emit(BreedPicturesLoading());
       print(event.breed);
        await repository.getBreedPictures("https://dog.ceo/api/breed/${event.breed}/images")
        .then((value) {
          if(value != null){
            print(value);
            emit(BreedPicturesLoaded(value));
          }
          else {
            emit(BreedPicturesError("errorMessage"));
          }
        });
      // TODO: implement event handler
    });
  }
}
