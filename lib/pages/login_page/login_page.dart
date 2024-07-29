import 'package:flutter/material.dart';
import 'package:survey/pages/login_page/components/my_button.dart';
import 'package:survey/pages/login_page/components/my_textfield.dart';
import 'package:survey/pages/login_page/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  void signUserIn() {
    print("ajillj baina ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: userNameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: passWordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password',
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(onTap: signUserIn),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath:
                          'https://imgs.search.brave.com/WNmYnN33P-81WgMcwlDKQXxypuypMVEcihrqyg27o_s/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dHMuc3RpY2twbmcu/Y29tL2ltYWdlcy81/ODQ3ZjljYmNlZjEw/MTRjMGI1ZTQ4Yzgu/cG5n',
                    ),
                    SquareTile(
                      imagePath:
                          'https://cdn-icons-png.flaticon.com/128/0/747.png',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member? '),
                    Text(
                      'Register Now!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
