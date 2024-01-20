import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task/repository/repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  Repository repository;
  ThemeBloc({required this.repository}) : super(ThemeData.light()) {
    on<InitialThemeSetEvent>((event,state){
      bool isDark = isDarkTheme();
      if(isDark){
        emit(ThemeData.dark());
      }
      else{
        emit(ThemeData.light());
      }
      repository.saveTheme(isDark);
    });
    on<ThemeSwitchEvent>((event, emit) {
      final isDark = isDarkTheme();
      emit(isDark?ThemeData.light():ThemeData.dark());
      repository.saveTheme(!isDark);
    });
  }
  bool isDarkTheme(){
    return repository.getTheme();
  }
}
