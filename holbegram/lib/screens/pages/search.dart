import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;


    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(238, 238, 238, 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    
                  },
                ),
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // この部分は、Firestoreからデータを取得する実際のクエリに置き換えてください
        stream: firestore.collection('posts').snapshots(),
        builder: (context, snapshot) {
          // ストリームの接続状態
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No Post Found'));
          }

          var documents = snapshot.data!.docs;

           return StaggeredGrid.count( // 異なるサイズのタイルを持つグリッドを作成
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: List.generate(documents.length, (int index) {
              return StaggeredGridTile.count( // グリッドのアイテム（タイル）
                crossAxisCellCount: 2,
                mainAxisCellCount: index.isEven ? 2 : 3,
                child: Image.network(
                  documents[index]['postUrl'], 
                  fit: BoxFit.cover,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}