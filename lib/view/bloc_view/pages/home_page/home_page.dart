import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/list_of_dog_breeds/list_of_dog_breeds_bloc.dart';
import 'package:task/service_locator.dart';
import 'package:task/view/bloc_view/pages/home_page/widgets/list_all_breeds_widget.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed('/setting');
            }, icon: const Icon(Icons.settings))
          ],
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

  @override
  void dispose() {
    super.dispose();
    getIt.get<ListOfDogBreedsBloc>().close();
    print("end");
  }
}

