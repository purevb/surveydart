import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey/pages/survey/new_home_page.dart';

// ignore: must_be_immutable
class AnimationPage extends StatefulWidget {
  String id;
  AnimationPage({super.key, required this.id});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewHomePage(id: widget.id),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Center(
      child: Stack(
        children: [
          Lottie.asset(
            "assets/handshake.json",
            controller: _controller,
          ),
          Lottie.asset(
            "assets/congrats.json",
            controller: _controller,
          ),
          Lottie.asset(
            "assets/ty.json",
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
