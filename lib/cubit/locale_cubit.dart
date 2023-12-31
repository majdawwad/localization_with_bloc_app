import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../language_cache_helper.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial());

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLocaleLanguageState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleLanguageState(locale: Locale(languageCode)));
  }
}
