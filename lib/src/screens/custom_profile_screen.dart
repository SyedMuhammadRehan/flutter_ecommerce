import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/routing/app_router.dart';
import 'package:flutter_ecommerce/src/screens/ui_auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomProfileScreen extends ConsumerWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authprovider = ref.watch(authenticationProviders);
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      providers: authprovider,
    );
  }
}
