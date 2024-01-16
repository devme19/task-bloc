import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/data_provider.dart';

class ShowBreedPicturesWidget2 extends ConsumerWidget {
  ShowBreedPicturesWidget2({super.key,required this.items});
  List<String> items;
  List<String> likedItems=[];

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    likedItems= ref.watch(likeUnlikeImageProvider(ref)).favourites!;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // number of items in each row
        mainAxisSpacing: 8.0, // spacing between rows
        crossAxisSpacing: 8.0,
        childAspectRatio:0.5,
      ),
      // padding: const EdgeInsets.all(8.0), // padding around the grid
      itemCount: items.length, // total number of items
      itemBuilder: (context, index) {
        return  GestureDetector(
          onDoubleTap: (){
            ref.watch(likeUnlikeImageProvider(ref)).likeImage(items[index]);
            // likeImageBloc!.add(LikedImageEvent(item: widget.items[index],likedItems: likedItems));
          },
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: items[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: createLikeIcon(index,ref),
              ),
              const SizedBox(height: 30,)
            ],
          ),
        );

      },
    );
  }
  Widget createLikeIcon(int index,WidgetRef ref){
    if(likedItems.contains(items[index])){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              child: Image.asset('assets/images/like.png',width: 50,),
              onTap: (){
                ref.watch(likeUnlikeImageProvider(ref)).unLikeImage(items[index]);
                // likedItems = ref.watch(likeImageProvider(items[index]));
                print(likedItems);
              }),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          child: Image.asset('assets/images/unlike.png',width: 50,),
          onTap: (){
            ref.watch(likeUnlikeImageProvider(ref)).likeImage(items[index]);
            // likedItems = ref.watch(likeImageProvider(items[index]));
            print(likedItems);
          },
        ),
      ],
    );
  }
}



// class ShowBreedPicturesWidget2 extends StatefulWidget {
//   ShowBreedPicturesWidget2({super.key,required this.items});
//   List<String> items;
//
//
//   @override
//   State<ShowBreedPicturesWidget2> createState() => _ShowBreedPicturesWidgetState();
//
// }
//
// class _ShowBreedPicturesWidgetState extends State<ShowBreedPicturesWidget2> {
//
//   List<String> likedItems=[];
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1, // number of items in each row
//         mainAxisSpacing: 8.0, // spacing between rows
//         crossAxisSpacing: 8.0,
//         childAspectRatio:0.5,
//       ),
//       // padding: const EdgeInsets.all(8.0), // padding around the grid
//       itemCount: widget.items.length, // total number of items
//       itemBuilder: (context, index) {
//         return  GestureDetector(
//           onDoubleTap: (){
//             // likeImageBloc!.add(LikedImageEvent(item: widget.items[index],likedItems: likedItems));
//           },
//           child: Column(
//             children: [
//               Expanded(
//                 child: CachedNetworkImage(
//                   imageUrl: widget.items[index],
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) => Container(),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//               ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: createLikeIcon(index),
//              ),
//               const SizedBox(height: 30,)
//             ],
//           ),
//         );
//
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//   Widget createLikeIcon(int index){
//     if(likedItems.contains(widget.items[index])){
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           InkWell(
//               child: Image.asset('assets/images/like.png',width: 50,),
//               onTap: (){}),
//         ],
//       );
//     }
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         InkWell(
//           child: Image.asset('assets/images/unlike.png',width: 50,),
//           onTap: (){},
//         ),
//       ],
//     );
//   }
// }
