import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task/bloc/language_bloc.dart';
import 'package:task/bloc/theme/theme_bloc.dart';
import 'package:task/service_locator.dart';
import 'package:theme_button/theme_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedLanguage="English";
  List<String> languages=["English","Persian"];
  bool isEn = true;
  // @override
  // void dispose() {
  //   super.dispose();
  //   getIt<ThemeBloc>().close();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Theme".tr()),
              ThemeButton(
                width: 70,

                onChanged: (bool isDark)
                {
                  getIt.get<ThemeBloc>().add(ThemeSwitchEvent());
                }
                    // isDark?getIt<ThemeBloc>().add(DarkThemeEvent()):getIt<ThemeBloc>().add(LightThemeEvent()),
              )
            ],),
          Divider(),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Language".tr()),
              DropdownButton(
                  value: selectedLanguage,
                  items: languages.map((e) => DropdownMenuItem(
                    value: e,child: Text(e.tr()),)).toList(),
                  onChanged: (value){
                    print(value);
                    print("selected Lang "+value.toString());
                    getIt.get<LanguageBloc>().add(LoadLanguageEvent(locale: Locale('fa','IR')));
                    setState(() {
                      selectedLanguage = value.toString();
                    });
                  }
              )
          ],)
        ],),
      ),
    );
  }
}
