import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart' hide Job;
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/data/firestore_repository.dart';
import 'package:flutter_ecommerce/src/data/job.dart';
import 'package:flutter_ecommerce/src/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Jobs'), actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => context.goNamed(AppRoute.profile.name),
        )
      ]),
      body: const JobListView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final user = ref.read(firebaseAuthProvider).currentUser;
          final faker = Faker();

          ref.read(firestoreRepositoryProvider).addJob(
                user!.uid,
                faker.job.title(),
                faker.company.name(),
              );
        },
      ),
    );
  }
}

class JobListView extends ConsumerWidget {
  const JobListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebasefirestore = ref.watch(firestoreRepositoryProvider);
    final user = ref.read(firebaseAuthProvider).currentUser;
    return FirestoreListView<Job>(
      query: firebasefirestore.jobQuery(user!.uid),
      itemBuilder: (BuildContext context, QueryDocumentSnapshot<Job> doc) {
        final data = doc.data();
        return Dismissible(
          key: Key(doc.id),
          direction: DismissDirection.endToStart,
          background: const ColoredBox(
            color: Colors.red,
          ),
          onDismissed: (direction) async {
            final user = ref.read(firebaseAuthProvider).currentUser;
            ref.read(firestoreRepositoryProvider).deletejob(user!.uid, doc.id);
          },
          child: ListTile(
            title: Text(data.title),
            subtitle: Text(data.company),
            onTap: () {
              final user = ref.read(firebaseAuthProvider).currentUser;
              ref.read(firestoreRepositoryProvider).updatejob(
                  user!.uid, faker.job.title(), faker.company.name(), doc.id);
            },
          ),
        );
      },
    );
  }
}
