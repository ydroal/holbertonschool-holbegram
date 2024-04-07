import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import './sigup_screen.dart';


class LoginScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  // コンストラクタ
  const LoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late bool passwordVisible; // パスワードの表示/非表示状態

  @override
  void initState() {
    super.initState();
    passwordVisible = true; // 初期状態を設定
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }

  // UIの構築
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarなし、余分なナビゲーション要素は省略
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
                  const SizedBox(height: 28),
                ],
              ),
            ),
            // ログインボタン
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
                  // ログイン処理をここに追加
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 「ログイン詳細を忘れましたか？」のテキスト
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgot your login details? '),
                Text(
                  'Get help logging in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 2), // 区切り線
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp(
                          emailController: TextEditingController(),
                          usernameController: TextEditingController(),
                          passwordController: TextEditingController(),
                          passwordConfirmController: TextEditingController()
                        )), // 適切な引数を渡す
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(218, 226, 37, 24)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Divider(thickness: 2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('OR'),
                ),
                Flexible(
                  child: Divider(thickness: 2),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Googleでサインインボタン
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png', // Googleロゴのパスを設定
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 10),
                const Text("Sign in with Google"),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

  