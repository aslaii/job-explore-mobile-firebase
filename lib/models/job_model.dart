// lib/models/job_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String id;
  final String jobName;
  final String company;
  final DateTime datePosted;

  JobModel({
    required this.id,
    required this.jobName,
    required this.company,
    required this.datePosted,
  });

  factory JobModel.fromMap(Map<String, dynamic> data, String id) {
    return JobModel(
      id: id,
      jobName: data['jobName'] ?? '',
      company: data['company'] ?? '',
      datePosted: (data['datePosted'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobName': jobName,
      'company': company,
      'datePosted': Timestamp.fromDate(datePosted),
    };
  }
}
