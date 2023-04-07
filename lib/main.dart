import 'package:car_wash_proj/app_router.dart';
import 'package:car_wash_proj/features/auth/screens/auth_checker.dart';
import 'package:car_wash_proj/firebase_options.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.debug,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: Navigation.instance.navigationKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: const AuthChecker(),
    );
  }
}
