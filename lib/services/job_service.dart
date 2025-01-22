import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_model.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<JobModel>> getJobs() async {
    try {
      final querySnapshot = await _firestore
          .collection('jobs')
          .orderBy('datePosted', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => JobModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching jobs: $e');
      return [];
    }
  }

  Future<void> createJob(String jobName, String company) async {
    try {
      await _firestore.collection('jobs').add({
        'jobName': jobName,
        'company': company,
        'datePosted': Timestamp.now(),
      });
    } catch (e) {
      print('Error creating job: $e');
      rethrow;
    }
  }
}
