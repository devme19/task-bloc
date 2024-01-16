import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/data_provider.dart';
import 'package:task/view/riverpod_view/breed_pictures_page/widgets/show_breed_pictures_widget.dart';

class BreedPicturesPage2 extends StatelessWidget {

  const BreedPicturesPage2({super.key});
  @override
  Widget build(BuildContext context) {
    final  breed = ModalRoute.of(context)!.settings.arguments;
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Pictures of $breed'),
        ),
        body:
        Consumer(builder:(_,WidgetRef ref,__){
          return ref.watch(getBreedPictureProvider("https://dog.ceo/api/breed/$breed/images")).when(
              data: (data)=>ShowBreedPicturesWidget2(items:data.message!),
              error: (error,e)=>const Center(child: Text("Error"),),
              loading: ()=>const Center(child: CircularProgressIndicator()));}
        ));
  }


}


