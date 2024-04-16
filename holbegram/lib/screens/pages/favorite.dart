import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/login_screen.dart';


class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Billabong',
          ),
        ), // ページタイトル
        centerTitle: false, 
      ),
      body: user == null
        ? Center( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Please log in'),
                ElevatedButton(
                  child: const Text('Login'),
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
        : StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No favorites items'));
            }
            List<dynamic> saved = snapshot.data!['saved'] ?? [];

            return ListView.builder(
              itemCount: saved.length,
              itemBuilder: (context, index) {
                String imageUrl = saved[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                );
              },
            );
          },
          ),
    );
  }
}
 