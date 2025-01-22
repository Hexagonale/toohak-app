import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';

import 'cubit/registration_cubit.dart';

class RegistrationBody extends StatefulWidget {
  const RegistrationBody({super.key});

  @override
  State<RegistrationBody> createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _emailInputKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordInputKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text(
                'Create an account',
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
              const SizedBox(height: 2.0),
              ThPasswordInput(
                formFieldKey: _passwordInputKey,
                labelText: 'Password',
                required: true,
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                title: 'Create an account',
                onTap: () {
                  if (_formKey.currentState?.validate() == true) {
                    context.read<RegistrationCubit>().register(
                          email: _emailInputKey.currentState!.value!,
                          password: _passwordInputKey.currentState!.value!,
                        );
                  }
                },
                size: ThPrimaryButtonSize.large,
                style: ThPrimaryButtonStyle.primary,
              ),
              const SizedBox(height: 24.0),
              TextButton(
                onPressed: () => thRouter.replace(ThRoutes.login.route),
                child: Text(
                  'Already have an account? Login',
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
