import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  toggleLocale(BuildContext context) {
    context.locale.languageCode == "ar"
        ? context.setLocale(const Locale("en"))
        : context.setLocale(const Locale("ar"));
  }

  getLocale(BuildContext context) {
    return context.locale.languageCode;
  }
}
