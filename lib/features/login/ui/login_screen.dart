import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:smart_home_app/core/helpers/app_regex.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/theming/colors.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:smart_home_app/core/widgets/app_text_button.dart';
import 'package:smart_home_app/core/widgets/app_text_form_field.dart';
import 'package:smart_home_app/features/login/data/cubit/login_cubit.dart';
import 'package:smart_home_app/features/login/widget/do_not_have_accont.dart';
import 'package:smart_home_app/features/login/widget/terms_condition.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/smart-house.png',
                  width: 100.w,
                  height: 100.h,
                  color: white,
                ),
                Gap(40.h),
                Text(
                  'Welcome Back',
                  style: TextStyles.font24BlueBold,
                ),
                Gap(20.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-mail',
                        style: TextStyles.font24BlueBold,
                      ),
                      Gap(8.h),
                      AppTextFormField(
                        controller: _emailController,
                        hintText: 'Enter your e-mail',
                        suffixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !AppRegex.isEmailValid(value)) {
                            return 'Please enter a valid e-mail';
                          }
                        },
                      ),
                      Gap(18.h),
                      Text(
                        'Password',
                        style: TextStyles.font24BlueBold,
                      ),
                      Gap(8.h),
                      AppTextFormField(
                        controller: _passwordController,
                        hintText: 'Enter your password',
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
                      Gap(18.h),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text.trim(),
                            );
                            AwesomeDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.scale,
                              title: 'Warning',
                              desc: 'Password reset email sent',
                            ).show();
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyles.font12BlueRegular,
                          ),
                        ),
                      ),
                      Gap(20.h),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            GoRouter.of(context)
                                .pushReplacement(AppRoutes.homePageScreen);
                          } else if (state is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)));
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AppTextButton(
                            buttonText: "Sign In",
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                  await FirebaseAuth.instance.currentUser!
                                      .reload();

                                  if (credential.user!.emailVerified) {
                                    setState(() {
                                      GoRouter.of(context).pushReplacement(
                                        AppRoutes.homePageScreen,
                                      );
                                    });
                                  } else {
                                    FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification();
                                    AwesomeDialog(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'Error',
                                      desc: 'Please verify your email',
                                    ).show();
                                  }
                                } on FirebaseAuthException catch (e) {
                                  String errorMessage;
                                  switch (e.code) {
                                    case 'invalid-email':
                                      errorMessage =
                                          'The email address is not valid.';
                                      break;
                                    case 'user-disabled':
                                      errorMessage =
                                          'The user account has been disabled.';
                                      break;
                                    case 'user-not-found':
                                      errorMessage =
                                          'No user found with this email.';
                                      break;
                                    case 'wrong-password':
                                      errorMessage = 'Incorrect password.';
                                      break;
                                    default:
                                      errorMessage =
                                          'An unknown error occurred.';
                                  }
                                  AwesomeDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: errorMessage,
                                  ).show();
                                } catch (e) {
                                  logger.e(e);
                                }
                              } else {
                                logger.e('Form is not valid');
                              }
                            },
                          );
                        },
                      ),
                      Gap(16.h),
                      const TermsAndConditionsText(),
                      Gap(16.h),
                      Gap(30.h),
                      const Center(
                        child: DontHaveAccountText(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> loginUser() async {
  //   // ignore: unused_local_variable
  //   UserCredential user =

  // }
}
