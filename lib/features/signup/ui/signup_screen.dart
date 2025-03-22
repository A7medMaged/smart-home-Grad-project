import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:smart_home_app/core/helpers/app_regex.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:smart_home_app/core/widgets/app_text_form_field.dart';
import 'package:smart_home_app/features/signup/ui/widgets/back_to_login.dart';

import '../../../core/widgets/app_text_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _register() async {
    if (formKey.currentState!.validate()) {
      try {
        // ignore: unused_local_variable
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': emailController.text,
          'name': nameController.text,
          'uid': userCredential.user!.uid,
        });

        // ignore: use_build_context_synchronously
        GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          logger.f('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'The account already exists for that email.',
          ).show();
          logger.f('The account already exists for that email.');
        }
      } catch (e) {
        logger.e(e);
      }
    } else {
      logger.e('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'sign-up'.tr(),
                  style: TextStyles.font24BlueBold,
                ),
                Gap(8.h),
                Text(
                  'we-wish-you-a-good-day, please-fill-in-the-form-to-create-an-account'
                      .tr(),
                  style: TextStyles.font14LightGrayRegular,
                ),
                Gap(36.h),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyles.font24BlueBold,
                        ),
                        Gap(8.h),
                        AppTextFormField(
                          controller: nameController,
                          hintText: 'Enter your name',
                          suffixIcon: const Icon(
                            Icons.person_outline,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                        ),
                        Gap(18.h),
                        Text(
                          'email'.tr(),
                          style: TextStyles.font24BlueBold,
                        ),
                        Gap(8.h),
                        AppTextFormField(
                          controller: emailController,
                          hintText: 'enter-email'.tr(),
                          suffixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !AppRegex.isEmailValid(value)) {
                              return 'Please enter a valid email';
                            }
                          },
                        ),
                        Gap(18.h),
                        Text(
                          'password'.tr(),
                          style: TextStyles.font24BlueBold,
                        ),
                        Gap(8.h),
                        AppTextFormField(
                          controller: passwordController,
                          hintText: 'enter-password'.tr(),
                          isObscureText: isObscureText,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                            child: Icon(
                              isObscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid password';
                            }
                          },
                        ),
                        Gap(40.h),
                        AppTextButton(
                          buttonText: "sign-up".tr(),
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: _register,
                        ),
                        Gap(20.h),
                        const Center(
                          child: BackToLoginScreen(),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
