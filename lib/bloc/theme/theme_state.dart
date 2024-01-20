part of 'theme_bloc.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);

  static ThemeState get darkTheme
  {
    print('********************');
    print("dark");
   return ThemeState(ThemeData.dark().copyWith(
  // Customize dark theme properties
  ));

}

  static ThemeState get lightTheme
  {
    print("light--");
  return ThemeState(ThemeData.light().copyWith(
  // Customize light theme properties
  ));
}
}
