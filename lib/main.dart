import 'package:dry_shades/FirebaseLogic/GoogleSigninProvider.dart';
import 'package:dry_shades/UI/Authentication-Screen/SplashScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'UI/PostScreen/PostScreen.dart';
import 'package:firebase_core/firebase_core.dart';
//rezu 01

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 837),
      builder: (BuildContext context, child){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
          ],
          child: MaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'DryShades',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}