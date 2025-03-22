import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.language,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        "change-language".tr(),
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      trailing: DropdownButton<Locale>(
        onChanged: (Locale? locale) {
          if (locale != null) {
            context.setLocale(locale);
          }
        },
        value: context.locale,
        items: [
          DropdownMenuItem(
            value: const Locale('en'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text("English",
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ),
          DropdownMenuItem(
            value: const Locale('ar'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:
                  Text("العربية", style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ],
        icon: Icon(Icons.arrow_drop_down_rounded,
            color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}
