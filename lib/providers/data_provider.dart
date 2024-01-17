import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/data/models/picture_model.dart';
import 'package:task/providers/providers.dart';

import '../data/models/all_breeds_model.dart';

final getAllBreedProvider = FutureProvider.family<AllBreedsModel,String>((ref,url) async{
          return ref.watch(repositoryProvider).getAllBreeds(url);
});
final getBreedPictureProvider = FutureProvider.family<PictureModel,String>((ref,url)async{
  return ref.watch(repositoryProvider).getBreedPictures(url);
});
final getFavouritesProvider = StateProvider.autoDispose<List<String>>((ref) {
  List<String> favourites = ref.watch(repositoryProvider).loadFavourites();
  return favourites;
});
final likeImageProvider = StateProvider.family.autoDispose<List<String>,String>((ref,item) {
  final repo = ref.watch(repositoryProvider);
  List<String> favourites = repo.loadFavourites();
  favourites.add(item);
  repo.saveFavourites(favourites);
  return favourites;
});
final loadBreedProvider = StateProvider.autoDispose<List<String>>((ref) => ref.watch(repositoryProvider).loadBreeds());
final filterBreedProvider = ChangeNotifierProvider.autoDispose<FilterBreedNotifier>((ref) => FilterBreedNotifier());
final likeUnlikeImageProvider = ChangeNotifierProvider.family.autoDispose<LikeUnsLikeImageNotifier,WidgetRef>((ref,r) => LikeUnsLikeImageNotifier(ref: r));

class FilterBreedNotifier extends ChangeNotifier{
  List<String> filteredItems=[];
  bool isFilter = false;
  String filterItem="Tap to filter";
  filter(String filter,List<String> items){
    filteredItems.clear();
    isFilter = true;
    filterItem = filter;
    for(String item in items){
      if(item.contains(filter)){
        filteredItems.add(item);
      }
    }
    notifyListeners();
  }
  clearFilter(){
    isFilter = false;
    filterItem = "Tap to filter";
    notifyListeners();
  }
}

class LikeUnsLikeImageNotifier extends ChangeNotifier{
  LikeUnsLikeImageNotifier({required this.ref}){
    favourites = ref!.watch(repositoryProvider).loadFavourites();
  }
  WidgetRef? ref;
  List<String>? favourites;
  likeImage(String item){
    favourites = ref!.watch(repositoryProvider).loadFavourites();
    favourites!.add(item);
    ref!.watch(repositoryProvider).saveFavourites(favourites!);
    notifyListeners();
  }
  unLikeImage(String item){
    favourites = ref!.watch(repositoryProvider).loadFavourites();
    favourites!.remove(item);
    ref!.watch(repositoryProvider).saveFavourites(favourites!);
    notifyListeners();
  }
}
