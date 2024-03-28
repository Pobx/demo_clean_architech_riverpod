import 'package:auto_route/auto_route.dart';
import 'package:demo_clean_architech_riverpod/features/authentication/presentation/providers/auth_providers.dart';
import 'package:demo_clean_architech_riverpod/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:demo_clean_architech_riverpod/features/authentication/presentation/widgets/auth_field.dart';
import 'package:demo_clean_architech_riverpod/routes/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  static const routeName = '/loginScreen';

  final TextEditingController usernameController =
      TextEditingController(text: 'kminchelle');
  final TextEditingController passwordController =
      TextEditingController(text: '0lelplR');

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateNotifierProvider);

    ref.listen(authStateNotifierProvider.select((value) => value),
        (previous, next) {
      // show Snackbar on failure
      if (next is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.exception.message.toString())));
      } else if (next is Success) {
        context.router
            .pushAndPopUntil(const DashboardRoute(), predicate: (_) => false);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('TDD with Riverpod'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          AuthField(
            hintText: 'Username',
            controller: usernameController,
          ),
          AuthField(
            hintText: 'Password',
            obscureText: true,
            controller: passwordController,
          ),
          state.maybeMap(
              loading: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
              orElse: () => loginButton(ref))
        ],
      )),
    );
  }

  Widget loginButton(WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          ref
              .read(authStateNotifierProvider.notifier)
              .logginUser(usernameController.text, passwordController.text);
        },
        child: const Text('Login'));
  }
}
