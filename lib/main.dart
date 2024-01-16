import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task/bloc/breed_pictures/breed_pictures_bloc.dart';
import 'package:task/bloc/favourites/favourites_bloc.dart';
import 'package:task/bloc/filter_by_breed/filter_by_breed_bloc.dart';
import 'package:task/bloc/like_image/like_image_bloc.dart';
import 'package:task/bloc/list_of_dog_breeds/list_of_dog_breeds_bloc.dart';
import 'package:task/data/data_sources/remote/remote_data_source.dart';
import 'package:task/repository/repository.dart';
import 'package:task/routes/bloc_route/RouteGenerator.dart';
import 'package:task/routes/riverpod_route/RouteGenerator2.dart';

import 'data/data_sources/local/local_data_source.dart';
import 'package:task/service_locator.dart';

void main() {
  // dependency_inject();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  final getIt = GetIt.instance;
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
     MaterialApp(
       title: 'Flutter Demo',
       onGenerateRoute: RouteGenerator2.generateRoute,
       initialRoute: '/',
       theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         useMaterial3: true,
       ),
     );
  }
}
// ignore: non_constant_identifier_names
dependency_inject(){
  getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl());
  getIt.registerSingleton<LocalDataSource>(LocalDataSourceImpl());
  getIt.registerFactory<Repository>(
        () => Repository(remoteDataSource: getIt<RemoteDataSource>(),localDataSource: getIt<LocalDataSource>()),
  );
  getIt.registerLazySingleton<ListOfDogBreedsBloc>(() => ListOfDogBreedsBloc(repository: getIt<Repository>()));
  getIt.registerFactory<LikeImageBloc>(() =>LikeImageBloc(repository: getIt<Repository>()) );
  getIt.registerFactory<FavouritesBloc>(() =>FavouritesBloc(repository: getIt<Repository>()), );
  getIt.registerFactory<FilterByBreedBloc>(() =>FilterByBreedBloc(repository: getIt<Repository>()) );
  getIt.registerFactory<BreedPicturesBloc>(() =>BreedPicturesBloc(repository: getIt<Repository>()));

}


