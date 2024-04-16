import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user.dart';
import '../auth/login_screen.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  Users? user;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    
  }

  Future<void> fetchUserData() async {
    if (userId.isEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
      )));
      return;
    }
    
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        setState(() {
          user = Users.fromSnap(userDoc);
          debugPrint('user: $user');
          debugPrint('userneme: $user.username');
        });
      } else {
        debugPrint('No user data available');
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Billabong',
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            iconSize: 30,
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen(
                    emailController: TextEditingController(),
                    passwordController: TextEditingController(),
                  )),
                );
              });
            },
          ),
        ],
      ),
      body: user == null
        ? Center( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Please log in'),
                ElevatedButton(
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(borderRadius: BorderRadius.zero) 
                  ),
                ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                    ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(
                        emailController: TextEditingController(),
                        passwordController: TextEditingController(),
                      )),
                    );
                  },
                ),
              ],
            ),
          )
      : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user?.photoUrl ?? 'https://via.placeholder.com/150'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatColumn(user!.posts.length, 'Posts'),
                          buildStatColumn(user!.followers.length, 'Followers'),
                          buildStatColumn(user!.following.length, 'Following'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // グリッドビューでユーザーの投稿を表示
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: user!.posts.length,
              itemBuilder: (context, index) {
                String postId = user!.posts[index]; // userのpost[]からpostIDを取得

                // IDを使用して投稿の詳細を取得するのでFutureBuilderを使用
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                      // snapshotからデータを抽出
                      Map<String, dynamic> postData = snapshot.data!.data() as Map<String, dynamic>;
                      String postImageUrl = postData['postUrl']; 

                      // 画像を表示
                      return Image.network(postImageUrl, fit: BoxFit.cover);
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                  );
                },
              )
          ]
        )
            ),
    );

          
  }

  Widget buildStatColumn(int count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
   
