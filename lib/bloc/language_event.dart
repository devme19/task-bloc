part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class LoadLanguageEvent extends LanguageEvent{
  final Locale locale;

  LoadLanguageEvent({required this.locale});

}
