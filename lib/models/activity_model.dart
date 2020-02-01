import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final int timestamp;
  final String title;
  final String image;

  ActivityModel({this.timestamp, this.title, this.image});

  factory ActivityModel.fromDocument(DocumentSnapshot snapshot) {
    return ActivityModel(
      timestamp: snapshot['timestamp'].seconds ?? 0,
      title: snapshot['title'] ?? "",
      image: snapshot['image'] ?? "",
    );
  }
}
