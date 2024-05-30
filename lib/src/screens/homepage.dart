import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Homapage extends ConsumerWidget {
  const Homapage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.goNamed(AppRoute.profile.name),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}
