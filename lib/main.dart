import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  runApp(const Toohak());
}
