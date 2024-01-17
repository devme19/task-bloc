
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/data/models/all_breeds_model.dart';
import 'package:task/repository/repository.dart';

part 'list_of_dog_breeds_event.dart';
part 'list_of_dog_breeds_state.dart';

class ListOfDogBreedsBloc extends Bloc<ListOfDogBreedsEvent, ListOfDogBreedsState> {

  Repository repository;
  ListOfDogBreedsBloc({required this.repository}) : super(ListOfDogBreedsInitial()) {

    on<ListOfDogBreedsEvent>((event, emit) async{
      if(event is ListOfDogBreedsEvent){
        emit(ListOfDogBreedsLoading());
        await repository.getAllBreeds("https://dog.ceo/api/breeds/list/all")
        // .onError((error, stackTrace) => emit(ListOfDogBreedsError(error.toString())))
        .then((value) {
          if(value != null){
            print(value);
            emit(ListOfDogBreedsLoaded(value));
          }
          else {
            emit(ListOfDogBreedsError("errorMessage"));
          }
        });
      }
    });
  }

  dispose() {}
}
