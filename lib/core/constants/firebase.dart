import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseMessaging fcm = FirebaseMessaging.instance;
