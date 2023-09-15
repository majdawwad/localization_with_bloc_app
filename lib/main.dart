import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:localization_tutorial/cubit/locale_cubit.dart';

import 'home_page_view.dart';
import 'intialize_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IntializeLocalization.initial();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FlutterLocalization localization = FlutterLocalization.instance;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
           if (state is ChangeLocaleLanguageState) {
            return MaterialApp(
              locale: state.locale,
              supportedLocales: localization.supportedLocales,
              localizationsDelegates: localization.localizationsDelegates,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              title: 'Localization App',
              home: const HomePageView(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
