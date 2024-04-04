import 'package:flutter/material.dart';


// ユーザーからテキスト入力を受け取るためのUI要素
class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  // コンストラクタ
  const TextFieldInput({
    super.key,  // key をスーパーパラメータとして直接渡す
    required this.controller,
    required this.isPassword,
    required this.hintText,
    this.suffixIcon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    // テキストフィールドの振る舞いや見た目をカスタマイズするプロパティを設定した
    // TextFieldウィジェットを返す
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: const Color.fromARGB(218, 226, 37, 24),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        contentPadding:const  EdgeInsets.all(8),
        suffixIcon: hintText == 'Password' 
          ? const Icon(Icons.visibility_off, color: Color.fromARGB(218, 226, 37, 24))
          : null,
      ),
      textInputAction: TextInputAction.next,
      obscureText: isPassword,
    );
  }
}