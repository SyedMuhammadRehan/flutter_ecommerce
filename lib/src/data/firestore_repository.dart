import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce/src/data/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> addJob(String uid, String title, String company) async {
    final docRef = await _firestore.collection('jobs').add({
      'uid': uid,
      'title': title,
      'company': company,
    });
    debugPrint(docRef.id);
  }

  Query<Job> jobQuery(String uid) {
    return _firestore
        .collection('jobs')
        .withConverter(
            fromFirestore: (snapsot, _) => Job.fromMap(snapsot.data()!),
            toFirestore: (jobsnapshot, _) => jobsnapshot.toMap())
        .where('uid', isEqualTo: uid);
  }

  Future<void> updatejob(
      String uid, String title, String company, String docid) async {
    await _firestore.collection('jobs').doc(docid).update({
      'uid': uid,
      'title': title,
      'company': company,
    });
  }

  Future<void> deletejob(String uid, String docid) async {
    await _firestore.collection('jobs').doc(docid).delete();
  }
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
