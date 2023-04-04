import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/0_data/exceptions/auth_exception.dart';
import 'package:real_estate_app/features/auth/0_data/models/auth_model.dart';

abstract class AuthRemoteDatasource {
  /// requests a random advice from api
  /// returns [AdviceModel] if successfull
  /// throws a server-Exception if status code is not 200
  Future<AuthModel> checkEmail({required String email});
  Future<UserCredential> signIn(
      {required String email, required String password});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDatasourceImpl({required this.auth, required this.firestore});

  @override
  Future<AuthModel> checkEmail({required String email}) async {
    debugPrint('masuk remote data');
    QuerySnapshot<AuthModel> fluffyDataRes = await firestore
        .collection('Users')
        .where('email', isEqualTo: email)
        .limit(1)
        .withConverter<AuthModel>(
          fromFirestore: (snapshot, options) {
            return AuthModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) => value.toJson(),
        )
        .get()
        .catchError(
      (err) {
        throw ServerException();
      },
    );

    if (fluffyDataRes.docs.isEmpty) {
      throw EmailNotFoundException();
    } else {
      final emailRes = fluffyDataRes.docs.first.data();

      debugPrint('hasil:${emailRes.email}');
      return emailRes;
    }
  }

  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    debugPrint('masuk remote data');
    UserCredential fluffyDataRes = await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError(
      (err) {
        throw ServerException();
      },
    );

    // final cleanDataRes = UserCredentialModel(
    //     credential: fluffyDataRes,
    //     accessToken: fluffyDataRes.credential!.accessToken!,
    //     displayName: fluffyDataRes.user!.displayName!,
    //     email: fluffyDataRes.user!.email!,
    //     isNewUser: fluffyDataRes.additionalUserInfo!.isNewUser,
    //     token: fluffyDataRes.credential!.token,
    //     uid: fluffyDataRes.user!.uid);

    return fluffyDataRes;
  }
}
