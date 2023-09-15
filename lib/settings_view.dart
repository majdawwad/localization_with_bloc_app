import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_tutorial/app_localizations.dart';
import 'package:localization_tutorial/cubit/locale_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "settings".tr(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<LocaleCubit, LocaleState>(
            listener: (context, state) {
              if (state is ChangeLocaleLanguageState) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is ChangeLocaleLanguageState) {
                return DropdownButton<String>(
                  value: state.locale.languageCode,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  items: ['ar', 'en'].map((String items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? value) async {
                    if (value != null) {
                      await context.read<LocaleCubit>().changeLanguage(value);
                    }
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
