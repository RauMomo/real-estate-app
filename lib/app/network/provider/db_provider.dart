import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DBProvider {
  init() async {
    const options = FirebaseOptions(
        apiKey: 'AIzaSyDPGj_syWj9pTJPvUgt5xrIesdpFjUw2QU',
        appId: '1:202145564954:android:c4e25a897234dbfce9c4a3',
        messagingSenderId: '202145564954',
        projectId: 'real-estate-app-ed177');
    final app = await Firebase.initializeApp(options: options);
    final auth = FirebaseAuth.instanceFor(app: app);

    auth.authStateChanges().listen((event) {
      if (event != null) {
        user = event;
      }
    });
  }

  User? user;
}
