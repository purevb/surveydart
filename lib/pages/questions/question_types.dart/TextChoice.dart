import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextChoice extends StatelessWidget {
  const TextChoice({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
            color: const Color(0xff910A67),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.only(right: 20, left: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.centers,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        backgroundColor: Colors.black),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Back",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "1/32",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Container(
                width: width * 0.9,
                height: height * 0.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/eq.png'))),
              ),
              const Text(
                "Tell us how u feel",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: width * 0.9,
                child: TextField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Input your answer here',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 10),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              SizedBox(
                width: width,
                height: height * 0.05,
                child:
                    ElevatedButton(onPressed: () {}, child: const Text("Next")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
