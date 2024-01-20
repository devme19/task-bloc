import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/breed_pictures/breed_pictures_bloc.dart';
import 'package:task/service_locator.dart';
import 'package:task/view/bloc_view/pages/breed_pictures_page/widgets/show_breed_pictures_widget.dart';

class BreedPicturesPage extends StatefulWidget {

  const BreedPicturesPage({super.key});

  @override
  State<BreedPicturesPage> createState() => _BreedPicturesPageState();
}

class _BreedPicturesPageState extends State<BreedPicturesPage> {
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

  @override
  void dispose() {
    super.dispose();
    getIt.get<BreedPicturesBloc>().close();
  }

}


