import 'dart:developer';

import 'package:car_wash_proj/bottom_nav/screens/home_screen.dart';
import 'package:car_wash_proj/features/auth/screens/otp_screen.dart';
import 'package:car_wash_proj/models/car_model.dart';
import 'package:car_wash_proj/models/user_model.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/streams.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/indicator/loader_indicator.dart';
import '../../../utils/utils.dart';

class AuthRepo {
  final FirebaseAuth _auth;
  AuthRepo(this._auth);

  final Streams _streams = Streams();

  Stream<User?> get authStateChange => _auth.idTokenChanges();
  String _verifyId = '';
  String get verifyId => _verifyId;

  String _userId = '';
  String get userID => _userId;

  User? _user;
  User? get user => _user;

  Future<void> signInUserWithPhone(String phone) async {
    try {
      Loading().witIndicator(
          context: Navigation.instance.navigationKey.currentState!.context,
          title: "Sending OTP");
      _auth.verifyPhoneNumber(
          // ignore: prefer_interpolation_to_compose_strings
          phoneNumber: "+91" + phone,
          verificationCompleted: ((phoneAuthCredential) {
            appToast("Verified Sucessfully :)");
          }),
          verificationFailed: (e) {
            //appToast( e.message.toString());
            appToast("wrong otp try again");
            log(e.toString());
          },
          codeSent: ((verificationId, forceResendingToken) {
            // setOtpsent();
            _verifyId = verificationId;
            Navigation.instance.navigateTo(OtpScreen.id.path);
            //Navigator.pushNamed(context, OtpScreen.id.path);
          }),
          codeAutoRetrievalTimeout: ((verificationId) {}));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> verifyOTP(
    String otp,
  ) async {
    log("came to verify otp");
    log(_verifyId);
    var a = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: _verifyId, smsCode: otp));
    if (a.user!.uid.isNotEmpty) {
      _user = a.user!;
      _userId = a.user!.uid;
      return a.user!.uid;
    } else {
      return "failed";
    }
    //return "";
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  saveUserToDb(UserModel userModel, CarModel carModel) {
    _streams.userQuery.doc(_userId).set(userModel.toMap()).then((value) {
      _streams.userQuery
          .doc(userModel.userId)
          .collection(Streams.custCars)
          .doc()
          .set(carModel.toMap())
          .then((value) {
        Navigation.instance.pushAndRemoveUntil(HomeScreen.id.path);
      });
    });
  }
}
