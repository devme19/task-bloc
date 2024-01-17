import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/data_provider.dart';
import 'package:task/view/riverpod_view/breed_pictures_page/widgets/show_breed_pictures_widget.dart';

class FavouritesPage2 extends ConsumerWidget {

  List<String> favourites=[];
  List<String> filteredItems=[];
  bool isFilter = false;
  String filterItem = "Tap to filter";
  FavouritesPage2({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    favourites= ref.watch(likeUnlikeImageProvider(ref)).favourites!;
    filteredItems = ref.watch(filterBreedProvider).filteredItems;
    isFilter = ref.watch(filterBreedProvider).isFilter;
    filterItem = ref.watch(filterBreedProvider).filterItem;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        actions: [
          GestureDetector(
            onTap: ()=>_modalBottomSheetMenu(context,favourites,ref),
            child:  Row(children: [
              Text(filterItem),
              const Icon(Icons.filter_alt)
            ],),
          )
        ],
      ),
      body: buildBody()
    );
  }
  Widget buildBody(){
    if(isFilter){
      if(filteredItems.isEmpty){
        return const Center(child: Text("There is no item"),);
      }
      return ShowBreedPicturesWidget2(items: filteredItems,);
    }
    if(favourites.isEmpty){
      return const Center(child: Text("There is no item"),);
    }
    return ShowBreedPicturesWidget2(items: favourites,);
  }
   void _modalBottomSheetMenu(context,List<String> favourites,WidgetRef ref){
    List<String> breeds = ref.watch(loadBreedProvider);
     showModalBottomSheet(
         context: context,
         builder: (builder){
           return Container(
               height: double.infinity,
               color: Colors.transparent, //could change this to Color(0xFF737373),
               //so you don't have to change MaterialApp canvasColor
               child:
               Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       GestureDetector(
                         onTap: (){
                           ref.watch(filterBreedProvider).clearFilter();
                           Navigator.pop(context);
                         },
                         child: const Padding(
                           padding: EdgeInsets.only(right: 16.0),
                           child: SizedBox(
                             height: 60,
                             width: 120,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 Text("Clear filter"),
                                 Icon(Icons.clear,color: Colors.red,)
                               ],
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                   Expanded(
                     child: ListView.builder(
                       itemCount:breeds.length,
                       itemBuilder: (BuildContext context, int index) {
                         return
                           ListTile(
                             onTap: (){
                               ref.watch(filterBreedProvider).filter(breeds[index], favourites);
                               Navigator.pop(context);
                             },
                             title: Text(breeds[index]),
                           );
                       },
                     ),
                   ),
                 ],
               )
           );
         }
     );
   }
}
