import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
	String uid;
  String email;
  String username;
  String bio;
  String photoUrl;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  List<dynamic> saved;
  String searchKey;

	Users({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.posts,
    required this.saved,
    required this.searchKey,
  });

  // FirestoreのDocumentSnapshotからUsersインスタンスを生成
  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data(); // snapからデータをを取得
    if (snapshot == null) {
      throw Exception('Document does not exist');
    }
    var userData = snapshot as Map<String, dynamic>; 
    // スナップショットからのデータを使用してUsersインスタンスを作成し、返す
    return Users(
      uid: userData['uid'],
      email: userData['email'],
      username: userData['username'],
      bio: userData['bio'],
      photoUrl: userData['photoUrl'],
      followers: userData['followers'],
      following: userData['following'],
      posts: userData['posts'],
      saved: userData['saved'],
      searchKey: userData['searchKey'],
    );
  }

  toJson() {
    return {
    'uid': uid,
    'email': email,
    'username': username,
    'bio': bio,
    'photoUrl': photoUrl,
    'followers': followers,
    'following': following,
    'posts': posts,
    'saved': saved,
    'searchKey': searchKey,
  };
  }
}