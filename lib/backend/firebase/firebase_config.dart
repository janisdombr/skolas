import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD53UgcL-wZ-FjayTj9T3YWdYJHriq1GUI",
            authDomain: "skolaslv.firebaseapp.com",
            projectId: "skolaslv",
            storageBucket: "skolaslv.appspot.com",
            messagingSenderId: "323416291303",
            appId: "1:323416291303:web:128ab7fb01d47bc66d2f42",
            measurementId: "G-WWW41Q518W"));
  } else {
    await Firebase.initializeApp();
  }
}
