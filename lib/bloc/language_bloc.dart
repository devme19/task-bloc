import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(LanguageState initialState) : super(initialState) {
    on<LanguageEvent>((event, emit) {
      if(event is LoadLanguageEvent){
        emit(LanguageState(locale: event.locale));
      }
    });
  }
  LanguageState get initialState => LanguageState.initial();
}
