import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/list_of_dog_breeds/list_of_dog_breeds_bloc.dart';
import 'package:task/view/bloc_view/pages/home_page/widgets/list_all_breeds_widget.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed('/favourites');
        },
      ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Task"),
        ),
        body:
            BlocBuilder<ListOfDogBreedsBloc,ListOfDogBreedsState>(
              builder: (BuildContext context, ListOfDogBreedsState state) {
                if(state is ListOfDogBreedsLoading){
                  print("isLoading");
                  return const Center(child: CircularProgressIndicator(),);
                }
                else if(state is ListOfDogBreedsLoaded){
                  // print(state.data.message);
                  return ListAllBreedsWidget(item: state.data,);
                }
                return const Center(child: Text("Error"),);


              },
            ),

    );
  }
}

