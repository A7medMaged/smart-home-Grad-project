import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/core/theming/text_style.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'by-logging,'.tr(),
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: ' ',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: 'you-agree-to-our'.tr(),
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: ' ',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: ' terms-and-conditions'.tr(),
            style: TextStyles.font13GrayRegular,
          ),
          TextSpan(
            text: ' ',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: ' and'.tr(),
            style: TextStyles.font13LightGrayRegular.copyWith(height: 1.6),
          ),
          TextSpan(
            text: ' ',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: ' privacy-policy'.tr(),
            style: TextStyles.font13GrayRegular,
          ),
        ],
      ),
    );
  }
}
