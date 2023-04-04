// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

class UserCredentialModel {
  UserCredential credential;
  bool isNewUser;
  String accessToken;
  int? token;
  String displayName;
  String uid;
  String email;

  UserCredentialModel({
    required this.credential,
    required this.isNewUser,
    required this.accessToken,
    required this.token,
    required this.displayName,
    required this.uid,
    required this.email,
  });
}
