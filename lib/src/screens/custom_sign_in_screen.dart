import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ecommerce/src/screens/ui_auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSignInScreen extends ConsumerWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authprovider = ref.watch(authenticationProviders);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SignInScreen(
        providers: authprovider,
        // actions: [
        //   AuthStateChangeAction<SignedIn>((context, state) {
        //     context.goNamed(AppRoute.profile.name);
        //   }),
        //   AuthStateChangeAction<UserCreated>((context, state) {
        //     context.goNamed(AppRoute.profile.name);
        //   })
        // ],
      ),
    );
  }
}
