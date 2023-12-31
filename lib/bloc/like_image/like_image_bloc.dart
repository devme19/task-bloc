import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/repository/repository.dart';
part 'like_image_event.dart';
part 'like_image_state.dart';
class LikeImageBloc extends Bloc<LikeImageEvent, LikeImageState> {
  Repository repository;
  LikeImageBloc({required this.repository}) : super(LikeImageInitial()) {
    on<LikedImageEvent>(mapLikedImageToState);
    on<UnLikedImageEvent>(mapUnLikedImageToState);
  }
  mapLikedImageToState(LikedImageEvent event,Emitter emit){
    event.likedItems!.add(event.item!);
    repository.saveFavourites(event.likedItems!);
    emit(LikedImageState(likedItems: event.likedItems));
  }
  mapUnLikedImageToState(UnLikedImageEvent event,Emitter emit){
    event.likedItems!.remove(event.item!);
    repository.saveFavourites(event.likedItems!);
    emit(LikedImageState(likedItems: event.likedItems));
  }
  List<String> getAllLikedImages(){
    return repository.loadFavourites();
  }
}
