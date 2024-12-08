import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/core/services/di_service.dart';
import 'package:luzu/core/widgets/loading_widget.dart';
import 'package:luzu/features/auth/data/models/logon_data_model.dart';
import 'package:luzu/features/auth/presentation/manager/login_cubit.dart';
import 'package:luzu/features/auth/presentation/pages/register_page.dart';
import 'package:luzu/features/home/home_page.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _cubit = getIt<LoginCubit>();

  @override
  void initState() {
    super.initState();
    _emailController.text = 'holzmanneduardo@gmail.com';
    _passwordController.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
          bloc: _cubit, listener: listener, builder: builder),
    );
  }

  Widget builder(context, state) {
    if (state is OnLoading || state is OnLoginSuccess) {
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
              'Login',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      actionLogin(context);
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => actionGoRegisterPage(context),
            child: const Text("Go Register Page"),
          )
        ],
      ),
    );
  }

  void actionGoRegisterPage(BuildContext context) {
    context.push(RegisterPage.routeName);
  }

  void actionLogin(context) {
    final data = LoginDataModel(
      email: _emailController.text,
      password: _passwordController.text,
    );
    _cubit.actionLoginOnFirebase(data);
  }

  void listener(BuildContext context, LoginState state) {
    if (state is OnLoginSuccess) {
      context.go(HomePage.routeName);
    }

    if(state is OnLoginFirebaseSuccess){
      _cubit.actionLogin(state.uid);
    }

    if (state is OnLoginFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.failure.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
