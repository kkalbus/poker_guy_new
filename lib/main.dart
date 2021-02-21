import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_guy/screens/big_widget.dart';
import 'package:poker_guy/services/auth.dart';
import 'package:provider/provider.dart';
import 'shared/loading.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  try {
    runApp(MyApp());
  }  on FirebaseFunctionsException catch (e) {
    print('main caught firebase functions exception');
    print(e.code);
    print(e.message);
    print(e.details);
  } on PlatformException catch (e) {
    print(e.message);
    print(e.details);
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static Size screenSize;
  static double screenWidth = 0;
  static double screenHeight = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MyApp.screenSize = MediaQuery.of(context).size;
    // MyApp.screenWidth = MyApp.screenSize.width;
    // MyApp.screenHeight = MyApp.screenSize.height;

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Loading();
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return Loading();
        }

        // Anonymous login persists the Firebase anonymous uid
        // across app instantiations, so we can rely on it as the
        // AppUser id

        final AuthService _auth1 = AuthService();

        _auth1.signInAnon();

        return MultiProvider(
          providers: [
            StreamProvider<User>.value(value: AuthService().user),
          ],
          child: LayoutBuilder(builder: (context, constraints) {
            return OrientationBuilder(builder: (context, orientation) {
              SizerUtil().init(constraints, orientation);
              return MaterialApp(
                color: Colors.green[500],
                home: BigWidget(),
                debugShowCheckedModeBanner: false,
              );
            });
          }),
        );
      },
    );
  }
}
