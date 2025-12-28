import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyD5YDJ37NZnr01rg_xtSfzvJcXps_Wy6E0",
        authDomain: "weatherapp-main-b292c.firebaseapp.com",
        projectId: "weatherapp-main-b292c",
        storageBucket: "weatherapp-main-b292c.firebasestorage.app",
        messagingSenderId: "1075822454818",
        appId: "1:1075822454818:web:7ce7126ec6784751b3027b",
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: "AIzaSyD5YDJ37NZnr01rg_xtSfzvJcXps_Wy6E0",
        appId: "1:1075822454818:android:1366f30cf8eba943b3027b",
        messagingSenderId: "1075822454818",
        projectId: "weatherapp-main-b292c",
        storageBucket: "weatherapp-main-b292c.firebasestorage.app",
      );
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not supported for this platform.',
      );
    }
  }
}
