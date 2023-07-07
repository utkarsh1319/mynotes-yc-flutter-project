// Generated file, do not edit.

// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_analytics_web/firebase_analytics_web.dart';

// This function is called by the app's main() method
void registerPlugins(Registrar registrar) {
  // Registers the FirebaseFirestoreWeb plugin for web
  FirebaseFirestoreWeb.registerWith(registrar);
  
  // Registers the FirebaseAuthWeb plugin for web
  FirebaseAuthWeb.registerWith(registrar);
  
  // Registers the FirebaseCoreWeb plugin for web
  FirebaseCoreWeb.registerWith(registrar);
  
  // Registers the FirebaseAnalyticsWeb plugin for web
  FirebaseAnalyticsWeb.registerWith(registrar);
  
  // This line ensures that the web platform message communication is set up
  registrar.registerMessageHandler();
}
