import 'package:car_wash_proj/features/auth/controllers/auth_provider.dart';
import 'package:car_wash_proj/features/cars/companies/car_company.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/streams.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/routes.dart';

class OtpScreen extends ConsumerWidget {
  static const id = AppRoutes.otpScreen;
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            "CO",
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
          )),
          const Center(
              child: Text(
            "DE",
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
          )),
          const Center(
              child: Text(
            "VERIFICATION",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )),
          sbh(12),
          Text(
            "Enter OTP sent to your number",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.grey.shade600),
          ),
          sbh(12),
          OtpTextField(
            obscureText: false,
            numberOfFields: 6,
            showFieldAsBox: true,
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            focusedBorderColor: Colors.black.withOpacity(0.1),
            cursorColor: Colors.black.withOpacity(0.1),
            onSubmit: (value) async {
              //  ref.
              final verify = ref.read(authRepoProvider);
              String res = await verify.verifyOTP(value);
              if (res != "failed") {
                Streams streams = Streams();
                final user = await streams.userQuery
                    .where("userId", isEqualTo: res)
                    .get();
                if (user.docs.isNotEmpty) {
                } else {
                  Navigation.instance.navigateTo(CarCompanies.id.path);
                }
              } else {
                appToast("Wrong OTP try again");
              }
            },
          ),
          InkWell(
            onTap: () {
              final verify = ref.read(authRepoProvider);
              verify.verifyOTP("");
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Container(
                width: size.width / 1.4,
                height: 50,
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                    child: Text(
                  "VERIFY",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
