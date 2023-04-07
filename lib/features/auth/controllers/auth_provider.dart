import 'package:car_wash_proj/features/auth/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider<AuthRepo>(((ref) {
  return AuthRepo(FirebaseAuth.instance);
}));

final authStateProvider = StreamProvider<User?>(((ref) {
  return ref.read(authRepoProvider).authStateChange;
}));


