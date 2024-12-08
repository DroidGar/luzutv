import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/core/services/di_service.dart';
import 'package:luzu/core/widgets/loading_widget.dart';
import 'package:luzu/features/auth/presentation/manager/register_cubit.dart';
import 'package:luzu/features/home/home_page.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cubit = getIt<RegisterCubit>();

  @override
  void initState() {
    super.initState();
    // dummy data
    _emailController.text = 'holzmanneduardo@gmail.com';
    _passwordController.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer(bloc: _cubit, listener: listener, builder: builder));
  }

  Widget builder(BuildContext context, state) {
    if (state is OnLoading ||
        state is OnRegisterSuccess ||
        state is OnLoginSuccess) {
      return const LoadingWidget();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Register Page',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => actionRegister(context),
                child: const Text('Register'),
              ),
            ],
          ),
          TextButton(
            onPressed: () => actionGoLoginPage(context),
            child: const Text("Go Login Page"),
          )
        ],
      ),
    );
  }

  void listener(BuildContext context, RegisterState state) {
    if (state is OnLoginSuccess) {
      actionGoHomePage(context);
    }
    if (state is OnRegisterSuccess) {
      _cubit.actionLogin(state.uid);
    }
    if (state is OnRegisterFailure || state is OnLoginFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text((state as dynamic).failure.failure),
      ));
    }
    ;
  }

  actionGoHomePage(BuildContext context) {
    context.pushReplacement(HomePage.routeName);
  }

  actionGoLoginPage(BuildContext context) {
    context.pop();
  }

  actionRegister(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    _cubit.actionRegister(email, password);
  }
}
