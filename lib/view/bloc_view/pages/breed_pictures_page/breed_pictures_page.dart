import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/breed_pictures/breed_pictures_bloc.dart';
import 'package:task/view/bloc_view/pages/breed_pictures_page/widgets/show_breed_pictures_widget.dart';

class BreedPicturesPage extends StatelessWidget {

  const BreedPicturesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final  args = ModalRoute.of(context)!.settings.arguments;
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Pictures of $args'),
        ),
        body: BlocBuilder<BreedPicturesBloc,BreedPicturesState>(
            builder: (BuildContext context,BreedPicturesState state){
              if(state is BreedPicturesLoading){
                return const Center(child: CircularProgressIndicator(),);
              }
              else if(state is BreedPicturesLoaded){
                // print(state.data.message);
                return ShowBreedPicturesWidget(items: state.data.message!);
              }
              return const Center(child: Text("Error"),);
            }),
      );
  }


}


