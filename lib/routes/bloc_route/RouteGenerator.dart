import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/breed_pictures/breed_pictures_bloc.dart';
import 'package:task/bloc/favourites/favourites_bloc.dart';
import 'package:task/bloc/filter_by_breed/filter_by_breed_bloc.dart';
import 'package:task/bloc/list_of_dog_breeds/list_of_dog_breeds_bloc.dart';
import 'package:task/bloc/theme/theme_bloc.dart';
import 'package:task/service_locator.dart';
import 'package:task/view/bloc_view/pages/breed_pictures_page/breed_pictures_page.dart';
import 'package:task/view/bloc_view/pages/favourites_page/favourites_page.dart';
import 'package:task/view/bloc_view/pages/home_page/home_page.dart';
import 'package:task/view/bloc_view/pages/setting_page/setting_page.dart';


class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ListOfDogBreedsBloc>.value(
            value: getIt.get<ListOfDogBreedsBloc>()..add(FetchListOfDogBreedsEvent()),
            child:const MyHomePage(),
          ),
        );

      case '/pictures':
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args.toString()),
          builder: (_) => BlocProvider<BreedPicturesBloc>.value(
            value: getIt.get<BreedPicturesBloc>()..add(FetchBreedPicturesEvent(breed: args.toString())),
            child: const BreedPicturesPage()
          ),

        );
      case '/favourites':
        return MaterialPageRoute(
            builder: (_)=>
                MultiBlocProvider(providers: [
                    BlocProvider<FavouritesBloc>.value(
                        value: getIt.get<FavouritesBloc>()),
                    BlocProvider<FilterByBreedBloc>.value(
                        value: getIt.get<FilterByBreedBloc>()),
                ], child:  FavouritesPage())
        );
      case '/setting':
        return MaterialPageRoute(
            builder: (_)=>
                // MultiBlocProvider(providers: [
                //   BlocProvider<ThemeBloc>.value(value: getIt.get<ThemeBloc>()..add(InitialThemeSetEvent())),
                // ],
                    SettingPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}