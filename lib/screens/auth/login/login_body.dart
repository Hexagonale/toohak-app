import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';

import 'cubit/login_cubit.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _emailInputKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordInputKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ThAppScaffold(
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text(
                'Sign in',
                style: ThTextStyles.headlineH2Regular.copyWith(
                  color: ThColors.textText1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24.0),
              ThTextInput(
                formFieldKey: _emailInputKey,
                labelText: 'Email address',
                isRequired: true,
                withoutSpaces: true,
              ),
              const SizedBox(height: 4.0),
              ThPasswordInput(
                formFieldKey: _passwordInputKey,
                labelText: 'Password',
                required: true,
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                title: 'Sign in',
                onTap: () async {
                  if (_formKey.currentState?.validate() != true) {
                    return;
                  }

                  final LoginCubit cubit = context.read();
                  await cubit.login(
                    email: _emailInputKey.currentState!.value!,
                    password: _passwordInputKey.currentState!.value!,
                  );
                },
                size: ThPrimaryButtonSize.large,
                style: ThPrimaryButtonStyle.primary,
              ),
              const SizedBox(height: 24.0),
              TextButton(
                onPressed: () => thRouter.replace(ThRoutes.registration.route),
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: ThTextStyles.headlineH6Semibold.copyWith(
                    color: ThColors.ascentAscent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
