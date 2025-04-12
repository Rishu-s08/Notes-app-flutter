import 'package:flutter/material.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class CloudNote {
  final String documentId;
  final String text;
  final String ownerUserId;

  const CloudNote({
    required this.documentId,
    required this.text,
    required this.ownerUserId,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    : documentId = snapshot.id,
      text = snapshot.data()[textFieldName] as String,
      ownerUserId = snapshot.data()[ownerUserIdFieldName];
}
