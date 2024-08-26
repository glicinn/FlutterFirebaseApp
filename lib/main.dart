import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseapp/dj/service.dart';
import 'package:firebaseapp/features/home/app.dart';
import 'package:firebaseapp/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDJ();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}