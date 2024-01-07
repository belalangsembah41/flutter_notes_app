import 'package:flutter/material.dart';
import 'package:flutter_deshh/components/app_button.dart';
import 'package:flutter_deshh/components/input_field.dart';
import 'package:flutter_deshh/pages/home.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void checkUser() {
    final box = GetStorage();
    String? username = box.read('username');

    if (username != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const HomePage()));
      });
    }
  }

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username != 'admin' || password != 'admin') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username atau Password Salah"),
        ),
      );
      return;
    }
    final box = GetStorage();
    box.write('username', username);
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InputField(label: "Username", inputController: usernameController),
            const SizedBox(height: 20),
            InputField(label: "Password", inputController: passwordController),
            const SizedBox(height: 40),
            Button(
              label: "Login",
              backgroundColor: Colors.lightBlue,
              onPressed: (() {
                login();
              }),
            )
          ],
        ),
      ),
    );
  }
}
