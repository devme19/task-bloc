import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/breed_pictures/breed_pictures_bloc.dart';
import 'package:task/bloc/favourites/favourites_bloc.dart';
import 'package:task/bloc/filter_by_breed/filter_by_breed_bloc.dart';
import 'package:task/bloc/list_of_dog_breeds/list_of_dog_breeds_bloc.dart';
import 'package:task/service_locator.dart';
import 'package:task/view/bloc_view/pages/breed_pictures_page/breed_pictures_page.dart';
import 'package:task/view/bloc_view/pages/favourites_page/favourites_page.dart';
import 'package:task/view/bloc_view/pages/home_page/home_page.dart';
import 'package:task/view/riverpod_view/breed_pictures_page/breed_pictures_page.dart';
import 'package:task/view/riverpod_view/favourites_page/favourites_page.dart';
import 'package:task/view/riverpod_view/home_page/home_page.dart';


class RouteGenerator2 {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) =>const MyHomePage1()
        );

      case '/pictures':
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args.toString()),
          builder: (_) => const BreedPicturesPage2()
        );
      case '/favourites':
        return MaterialPageRoute(
            builder: (_)=>
                FavouritesPage2()
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}