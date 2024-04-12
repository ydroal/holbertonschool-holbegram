import 'package:flutter/material.dart';
// import '../../models/posts.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong', 
                fontSize: 32, 
              ),
            ),
            Image.asset(
              'assets/images/logo.webp', 
              height: 40,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.feed),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.feed),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('Posts() here'),
      ),
    );
  }
}

