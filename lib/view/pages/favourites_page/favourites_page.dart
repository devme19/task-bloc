import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/favourites/favourites_bloc.dart';
import 'package:task/bloc/filter_by_breed/filter_by_breed_bloc.dart';
import 'package:task/service_locator.dart';
import 'package:task/view/pages/breed_pictures_page/widgets/show_breed_pictures_widget.dart';

class FavouritesPage extends StatelessWidget {
  FavouritesBloc? favouritesBloc;
  FilterByBreedBloc? filterByBreedBloc;
  List<String> favourites=[];
  FavouritesPage({super.key}){
    favouritesBloc = getIt.get<FavouritesBloc>()..add(GetFavouritesEvent());
    filterByBreedBloc = getIt.get<FilterByBreedBloc>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        actions: [
          GestureDetector(
            onTap: ()=>_modalBottomSheetMenu(context,favourites),
            child: Row(children: [
              BlocBuilder<FilterByBreedBloc,FilterByBreedState>(
                bloc: filterByBreedBloc,
                  builder: (BuildContext context,FilterByBreedState state){
                if(state is FilterByBreedLoaded || state is FilterByBreedEmpty){
                  return Text(state.breed!);
                }
                return const Text("Tap to filter");

              }),
              const Icon(Icons.filter_alt)
            ],),
          )
        ],
      ),
      body: BlocBuilder<FavouritesBloc,GetFavouriteState>(
        bloc: favouritesBloc,
        builder: (BuildContext context,GetFavouriteState state){
        if(state is GetFavouritesLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(state is GetFavouritesError){
          return const Center(child: Text("Error"),);
        }
        else if(state is GetFavouritesLoaded) {
          favourites = state.favourites;
          return ShowBreedPicturesWidget(items: favourites);
        }
        else
        {
            return BlocBuilder<FilterByBreedBloc, FilterByBreedState>(
              bloc: filterByBreedBloc,
                builder: (BuildContext context, FilterByBreedState state) {
              if (state is FilterByBreedLoaded) {
                return ShowBreedPicturesWidget(items: state.filteredItems);
              } else if (state is FilterByBreedEmpty) {
                return const Center(
                  child: Text("There is no item"),
                );
              }
              return Container();
            });
          }
        },),
    );
  }
   void _modalBottomSheetMenu(context,List<String> favourites){
    List<String> breeds = filterByBreedBloc!.loadBreeds();
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
                           filterByBreedBloc!.add(ClearFilterEvent());
                           favouritesBloc!.add(GetFavouritesEvent());
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
                               favouritesBloc!.add(InitialFavouriteEvent());
                               filterByBreedBloc!.add(FilterBreedEvent(breed: breeds[index],items: favourites));
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
