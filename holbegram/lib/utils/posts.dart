import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';


class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  PostsState createState() => PostsState();
}

class PostsState extends State<Posts> {
  
  @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {

    // データが更新されるたびにUIを再構築する
    return StreamBuilder(
      // postsコレクションからのリアルタイムなストリームを返す
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return ListView.builder( // リストの各アイテムに対して一つ一つのウィジェットを生成する
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // ここで各ドキュメントにアクセス
              var docData = snapshot.data!.docs[index].data();
              // docData からデータを取り出し、UIに表示 // snapshotから取得したデータのドキュメントリストを格納
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8), // 上下左右に8の余白を設定
              height: 540,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(  // プロフィール画像を円形のコンテナ内に表示する
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(docData['profImage']),
                              ),
                            ),
                          ),
                        ),
                        Text(docData['username']),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () {
                            // Show snack with Text “Post Deleted”
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Text(docData['caption']),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(docData['postUrl']),
                      ),
                    ),
                    // Add the missing Icons that appear in the Picture
                  ),
                ],
              ),
            ),
          );
        },
      );
        } else {
            return const CircularProgressIndicator();
        }
      }
    );
  }
}