import 'dart:developer';

import 'package:car_wash_proj/features/auth/controllers/auth_provider.dart';
import 'package:car_wash_proj/features/auth/screens/login_screen.dart';
import 'package:car_wash_proj/features/splash_screen/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRefState = ref.watch(authStateProvider);
    return authRefState.when(data: ((data) {
      if (data != null) {
        log(data.uid);
        return SplashScreen(
          uid: data.uid,
        );
        //return const CarCompanies();
      } else {
        return const LoginScreen();

        //const CarCompanies();
      }
    }), error: ((error, stackTrace) {
      return const Text("data");
    }), loading: (() {
      return const CircularProgressIndicator();
    }));
  }
}
