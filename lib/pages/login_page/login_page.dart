import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/pages/login_page/components/square_tile.dart';
import 'package:survey/pages/login_page/register_page.dart';
import 'package:survey/pages/survey/new_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  Future<void> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> signUserIn() async {
    _formKey.currentState!.validate();
    if (emailController.text.isNotEmpty && passWordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passWordController.text
      };

      var response = await http.post(
        Uri.parse('http://10.0.2.2:3106/api/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        var id = jsonResponse['id'];
        await prefs.setString('token', myToken);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewHomePage(
                // token: myToken,
                id: id),
          ),
        );
        if (response.statusCode == 200) {
          print('Token checked');
        } else {
          print('Failed to check token');
          print(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password or email wrong')),
          );
        }
      } else {
        print("Error logging in");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password or email wrong')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: forgotPassword(height, context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> forgotPassword(double height, BuildContext context) {
    return [
      SizedBox(
        height: height * 0.1,
      ),
      const Icon(
        Icons.lock,
        size: 100,
        color: Color(0xffb3b3b3),
      ),
      const SizedBox(height: 50),
      const Text(
        'Welcome back you\'ve been missed!',
        style: TextStyle(color: Color(0xffb3b3b3), fontSize: 16),
      ),
      const SizedBox(height: 25),
      email(),
      const SizedBox(height: 25),
      passWord(),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forgot password',
              style: TextStyle(color: Color(0xffb3b3b3)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: signUserIn,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xff1db954),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "Sign in",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 40),
      divider(),
      const SizedBox(height: 35),
      const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SquareTile(
          //   imagePath: '',
          // ),
          // SquareTile(
          //   imagePath: '',
          // ),
        ],
      ),
      const SizedBox(height: 50),
      register(context),
    ];
  }

  Row register(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Not a member?',
          style: TextStyle(color: Color(0xffb3b3b3)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
          child: const Text(
            'Register Now!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Padding divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Or continue with',
              style: TextStyle(color: Color(0xffb3b3b3)),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField passWord() {
    return TextFormField(
      controller: passWordController,
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400)),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Buglu ';
        }
        return null;
      },
    );
  }

  TextFormField email() {
    return TextFormField(
      controller: emailController,
      obscureText: false,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400)),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: 'Username or Password',
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Buglu ';
        }
        return null;
      },
    );
  }
}
