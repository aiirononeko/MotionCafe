import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> authenticationUser() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await auth.signInWithEmailAndPassword(
      email: "tenpo@gmail.com",
      password: "tenpo1128",
    );
  } catch (e) {
    e;
  }
}
