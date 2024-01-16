import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/like_image/like_image_bloc.dart';
import 'package:task/service_locator.dart';

class ShowBreedPicturesWidget extends StatefulWidget {
  ShowBreedPicturesWidget({super.key,required this.items});
  List<String> items;


  @override
  State<ShowBreedPicturesWidget> createState() => _ShowBreedPicturesWidgetState();

}

class _ShowBreedPicturesWidgetState extends State<ShowBreedPicturesWidget> {

  List<String> likedItems=[];
  LikeImageBloc? likeImageBloc;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // number of items in each row
        mainAxisSpacing: 8.0, // spacing between rows
        crossAxisSpacing: 8.0,
        childAspectRatio:0.5,
      ),
      // padding: const EdgeInsets.all(8.0), // padding around the grid
      itemCount: widget.items.length, // total number of items
      itemBuilder: (context, index) {
        return  GestureDetector(
          onDoubleTap: (){
            likeImageBloc!.add(LikedImageEvent(item: widget.items[index],likedItems: likedItems));
          },
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: widget.items[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              BlocBuilder<LikeImageBloc,LikeImageState>(
                  bloc: likeImageBloc,
                  builder: (BuildContext context,LikeImageState state){
                    // if(state is LikedImageState){
                    //   likedItems = state.likedItems!;
                    // }
                     if(likedItems.contains(widget.items[index])){
                       return Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           InkWell(
                               child: Image.asset('assets/images/like.png',width: 50,),
                           onTap: ()=>likeImageBloc!.add(UnLikedImageEvent(item: widget.items[index],likedItems: likedItems)),),
                         ],
                       );
                     }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            child: Image.asset('assets/images/unlike.png',width: 50,),
                            onTap: ()=>likeImageBloc!.add(LikedImageEvent(item: widget.items[index],likedItems: likedItems)),
                        ),
                      ],
                    );

                  }),
              const SizedBox(height: 30,)
            ],
          ),
        );

      },
    );
  }

  @override
  void dispose() {
    likeImageBloc!.close();
    print("dispose");
    super.dispose();
  }

  @override
  void initState() {
    likeImageBloc = getIt.get<LikeImageBloc>();
    likedItems = likeImageBloc!.getAllLikedImages();
    print("Liked Images: $likedItems");
    super.initState();
  }
}
