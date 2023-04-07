import 'dart:developer';

import 'package:car_wash_proj/features/auth/controllers/auth_provider.dart';
import 'package:car_wash_proj/main.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../utils/routes.dart';
import 'components/other_login_method.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.loginScreen;
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepoProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.width,
              width: size.width,
              child: Image.network(
                "https://cars.tatamotors.com/images/punch/punch-suv-home-mob.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    // log(carImages.length.toString());
                    // log(carNames.length.toString());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Lets Shine :)",
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        icon: Text("+91"),
                       //suffix: Icon(Icons.call),
                        hintText: "Enter Your Mobile Number    "),
                  ),
                ),
                sbh(24),
                InkWell(
                  onTap: () async {
                    log(phoneController.text);
                    await auth.signInUserWithPhone(phoneController.text);
                  },
                  child: Center(
                    child: Container(
                      width: size.width / 1.2,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.black),
                      child: const Center(
                          child: Text(
                        "Send OTP",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
                sbh(24),
                const Center(
                  child: Text("Or   login with"),
                ),
                sbh(12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoginMethodButton(
                        widget: Image.asset(
                          Constants.fbIcon,
                          scale: 2,
                        ),
                        text: "",
                        onpressed: () async {
                          //fbLogin();
                        },
                      ),
                    ),
                    sbw(8),
                    Center(
                      child: LoginMethodButton(
                        widget: Image.asset(
                          Constants.googleIcon,
                          scale: 25,
                        ),
                        text: "",
                        onpressed: () {
                          //googlelogin();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
