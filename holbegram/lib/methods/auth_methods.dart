import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// 固定サイズのバイナリデータのリストを、汎用のListクラスよりも効率的に扱うために使用される
import 'dart:typed_data';
import '../models/user.dart';
import '../screens/auth/methods/user_storage.dart';
import 'package:flutter/foundation.dart';

class AuthMethode {
  // これらのインスタンスは不変なのでfinal
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future login({required String email,required String password,}) async {
    if (email.isEmpty || password.isEmpty) return 'Please fill all the fields';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  // signUpメソッド
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file, // ユーザープロフィール画像のファイルのバイナリデータ
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      String photoUrl = ''; // 初期値として空文字列を設定
      if (user != null && file != null) {
          // Storageに画像をアップロードし、URLを取得
          photoUrl = await _storageMethods.uploadImageToStorage(true,'profilePics', file);
      }
      if (user != null) {
        Users newUser = Users(
          uid: user.uid,
          email: user.email ?? '',
          username: username,
          bio: '', // 初期状態では空
          photoUrl: photoUrl,
          followers: [], // 空のまま初期化
          following: [], // 空のまま初期化
          posts: [], // 空のまま初期化
          saved: [], // 空のまま初期化
          searchKey: username.substring(0, 1).toUpperCase(), 
        );
        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
        return 'success';
      } else {
        return 'User creation failed';
      }
    } on FirebaseAuthException catch (e) {
        return e.message ?? 'An error occurred';
    }
  }

  Future<Users> getUserDetails() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userSnap = await _firestore.collection('users').doc(currentUser.uid).get();
      if (userSnap.exists) {
        return Users.fromSnap(userSnap);
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('User not found');
    }
  }
}
