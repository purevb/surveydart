import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:survey/pages/login_page/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isNotValidate = false;
  String _responseMessage = '';

  Future<void> postQuestion() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2:3106/api/user'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );
        var responseTest = jsonDecode(response.body);
        if (response.statusCode == 200) {
          setState(() {
            _responseMessage = 'user posted successfully!';
            _isNotValidate = false;
            print(_responseMessage);
            print(responseTest['status']);
            if (responseTest['status'] == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          });
        } else {
          setState(() {
            _responseMessage = 'Failed to post user. Please try again.';
            _isNotValidate = true;
            print(_responseMessage);
          });
        }
      } catch (e) {
        setState(() {
          _responseMessage = 'Error: $e';
          _isNotValidate = true;
          print(_responseMessage);
        });
      }
    } else {
      setState(() {
        _isNotValidate = true;
        _responseMessage = 'Please fill in all fields';
        print(_responseMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff121212),
        appBar: AppBar(
          foregroundColor: const Color(0xffb3b3b3),
          backgroundColor: const Color(0xff121212),
          title: const Text(
            'Register',
            style: TextStyle(color: Color(0xffb3b3b3)),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 24, color: Color(0xffb3b3b3)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  errorText: _isNotValidate ? "Enter a E-mail" : null,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'E-Mail',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: _isNotValidate ? "Enter password" : null,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width,
                child: ElevatedButton(
                  onPressed: postQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff252525),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
