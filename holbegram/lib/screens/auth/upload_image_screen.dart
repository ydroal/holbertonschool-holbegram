import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  // コンストラクタ
  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  AddPictureState createState() => AddPictureState();
}

class AddPictureState extends State<AddPicture> {
  Uint8List? _image;
  final picker = ImagePicker();

  Future<void> selectImageFromGallery() async {
    // XFileは、Flutterのimage_pickerライブラリで使用されるクラス。選択したファイルの情報をカプセル化するために使用
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // XFile.readAsBytesを使ってファイルをバイト配列に読み込み
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        // Uint8List.fromListでFlutterが表示できるUint8Listに変換
        _image = Uint8List.fromList(imageData);
      });
    }
  }

  Future<void> selectImageFromCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final Uint8List cameraData = await photo.readAsBytes();
      setState(() {
        _image = Uint8List.fromList(cameraData);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // UIの構築
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            Image.asset(
              'assets/images/logo.webp', // ここにロゴのアセットへのパスを指定
              width: 80,
              height: 60,
            ),
            const SizedBox(height: 28),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, John Doe Welcome to\nHolbegram.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Choose an image from your gallery or take a new one.',
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,// Adjust the font size as needed
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            _image != null
              ? Image.memory( // Uint8Listデータを表示するには、必ずImage.memoryを使用
                  _image!, // _imageはnull許容変数なのでコンパイル時エラーが発生しないよう!をつける
                  width: 200,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/Sample_User_Icon.png',
                  width: 280,
                  fit: BoxFit.cover,
              ),
            // const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(right: 80, left: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_library),
                    color: const Color.fromARGB(218, 226, 37, 24),
                    iconSize: 50,
                    onPressed: () => selectImageFromGallery(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    color: const Color.fromARGB(218, 226, 37, 24),
                    iconSize: 50,
                    onPressed: () => selectImageFromCamera(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 38),
            SizedBox(
              height: 46,
              width: 120,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
                onPressed: () {
                  // 後で実装
                },
                child: const Text('Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}