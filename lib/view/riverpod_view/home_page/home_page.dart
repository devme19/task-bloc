import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/data_provider.dart';
import 'package:task/view/bloc_view/pages/home_page/widgets/list_all_breeds_widget.dart';
class MyHomePage1 extends ConsumerWidget {
  const MyHomePage1({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final data = ref.watch(getAllBreedProvider("https://dog.ceo/api/breeds/list/all"));
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
            data.when(data:
            (data){
              return  ListAllBreedsWidget(item: data);
            },
                error: (error,s)=> const Center(child: Text("Error"),),
                loading: ()=>const Center(child: CircularProgressIndicator()))
    );
  }
}

