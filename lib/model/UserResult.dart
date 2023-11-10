import 'package:cloud_firestore/cloud_firestore.dart';

class UserResult {
  final String id;
  final String examId;
  final String userId;
  final Timestamp timeStamp;
  final int totalResult;

  // Other fields you want to store

  UserResult({required this.id,required this.examId, required this.userId,required this.timeStamp, required this.totalResult});
}

class ChapterResult {
  final String id;
  final int correctAnswer;
  final int incorrectAnswer;
  // Other fields you want to store

  ChapterResult({required this.id, required this.correctAnswer,required this.incorrectAnswer});
}