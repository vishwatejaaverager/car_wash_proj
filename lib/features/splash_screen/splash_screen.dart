import 'package:car_wash_proj/bottom_nav/screens/home_screen/screens/home_screen.dart';
import 'package:car_wash_proj/features/auth/screens/login_screen.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/streams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  final String uid;
  const SplashScreen({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    checkUser(widget.uid);
    super.initState();
  }

  Future checkUser(String id) async {
    Streams().userQuery.where("userId", isEqualTo: id).get().then((value) {
      if (value.docs.isNotEmpty) {
        Navigation.instance.pushAndRemoveUntil(HomeScreen.id.path);
      } else {
        Navigation.instance.pushAndRemoveUntil(LoginScreen.id.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
