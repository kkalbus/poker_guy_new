import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_guy/screens/big_widget.dart';
import 'package:poker_guy/services/auth.dart';
import 'package:provider/provider.dart';
import 'shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static Size screenSize = new Size(0,0);
  static double screenWidth = 0;
  static double screenHeight = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyApp.screenWidth = MyApp.screenSize.width;

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Loading();
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return Loading();
        }

        final AuthService _auth1 = AuthService();
        _auth1.signInAnon();

        return MultiProvider(
          providers: [
            StreamProvider<User>.value(value: AuthService().user),
          ],
          child: MaterialApp(
            color: Colors.green[500],
            home: BigWidget(),
          ),
        );
      },
    );
  }
}
