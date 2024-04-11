import 'package:flutter/material.dart';
import '../../widgets/text_field.dart'; 
import 'login_screen.dart';
import 'upload_image_screen.dart';

class SignUp extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  // コンストラクタ
  const SignUp({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
  });

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  late bool passwordVisible; // パスワードの表示/非表示状態
  late bool confirmPasswordVisible; // パスワードの表示/非表示状態

  @override
    void initState() {
      super.initState();
      passwordVisible = true;
      confirmPasswordVisible = true; 
    }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.usernameController.dispose();
    widget.passwordController.dispose();
    widget.passwordConfirmController.dispose();
    super.dispose();
  }
  
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30), 
              child: const Text(
                'Sign up to see photos and videos from your friends.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Email入力フィールド
                  TextFieldInput(
                    controller: widget.emailController,
                    isPassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  // 名前入力フィールド
                  TextFieldInput(
                    controller: widget.usernameController,
                    isPassword: false,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 24),
                  // パスワード入力フィールド
                  TextFieldInput(
                    controller: widget.passwordController,
                    isPassword: !passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // パスワード確認入力フィールド
                  TextFieldInput(
                    controller: widget.passwordConfirmController,
                    isPassword: !confirmPasswordVisible,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        confirmPasswordVisible  ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
            // サインナップボタン
            SizedBox(
              height: 48,
              width: double.infinity, // ボタンを幅いっぱいに広げる
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(borderRadius: BorderRadius.zero) // 角の丸みをなくす
                  ),
                ),
                onPressed: () {
                  String email = widget.emailController.text;
                  String password = widget.passwordController.text;
                  String username = widget.usernameController.text;
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPicture(
                      email: email, password: password, username: username
                    )),
                  );
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 2), // 区切り線
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen(
                          emailController: TextEditingController(),
                          passwordController: TextEditingController(),
                        )), // 適切な引数を渡す
                      );
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(218, 226, 37, 24)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

