import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/auth/presentation/manger/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../../core/services/network_services.dart';
import '../../../../core/widget/loading.dart';
import '../../../../core/widget/main_text_field.dart';
import '../../../../core/widget/validators.dart';
import '../../data/data_repositories/auth_repositories_impl.dart';
import '../../data/data_source/auth_data_source_impl.dart';
import '../manger/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(
            AuthRepositoriesImpl(
              AuthDataSourceImpl(
                NetworkServices(),
              ),
            ),
          ),
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is SignUpLoadingState) {
              Loading.showLoading(context);
            }
            else if (state is SignUpSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.signInRoute, (route) => false);
            }
            else if (state is SignUpErrorState) {
              Loading.hideLoading(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? "")));
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Form(
              key: formKey,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppSize.s40.h,
                        ),
                        Center(child: SvgPicture.asset(SvgAssets.routeLogo)),
                        SizedBox(
                          height: AppSize.s40.h,
                        ),
                        BuildTextField(
                          controller: cubit.nameController,
                          backgroundColor: ColorManager.white,
                          hint: 'enter your full name',
                          label: 'Full Name',
                          textInputType: TextInputType.name,
                          validation: AppValidators.validateFullName,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          controller: cubit.phoneController,
                          hint: 'enter your mobile no.',
                          backgroundColor: ColorManager.white,
                          label: 'Mobile Number',
                          validation: AppValidators.validatePhoneNumber,
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          controller: cubit.emailController,
                          hint: 'enter your email address',
                          backgroundColor: ColorManager.white,
                          label: 'E-mail address',
                          validation: AppValidators.validateEmail,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          controller: cubit.passwordController,
                          hint: 'enter your password',
                          backgroundColor: ColorManager.white,
                          label: 'password',
                          validation: AppValidators.validatePassword,
                          isObscured: true,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: AppSize.s24.h,
                        ),
                        BuildTextField(
                          controller: cubit.rePasswordController,
                          hint: 'confirm password',
                          backgroundColor: ColorManager.white,
                          label: 'confirm password',
                          validation: (value) {
                            AppValidators.validateConfirmPassword(value, cubit.passwordController.text);
                          },
                          isObscured: true,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: AppSize.s50.h,
                        ),
                        Center(
                          child: SizedBox(
                            height: AppSize.s60.h,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .9,
                            child: CustomElevatedButton(
                              // borderRadius: AppSize.s8,
                              label: 'Sign Up',
                              backgroundColor: ColorManager.white,
                              textStyle: getBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: AppSize.s20),
                              onTap: () {
                                if(formKey.currentState!.validate()){cubit.signUp();}
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),);
  }
}
