import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffa36cfe), Color(0xffe7e2fe)],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 57, 16, 122), Color(0xffe7e2fe)],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: height * 0.1, right: width * 0.05, left: width * 0.05),
          width: width * 0.9,
          height: height * 0.85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Colors.white),
          child: Text(""),
        ),
        Positioned(
          top: height * 0.11,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://img.freepik.com/free-vector/abstract-business-professional-background-banner-design-multipurpose_1340-16863.jpg?size=626&ext=jpg&ga=GA1.1.1570753395.1722498379&semt=ais_hybrid',
              height: height * 0.29,
              width: width * 0.85,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
