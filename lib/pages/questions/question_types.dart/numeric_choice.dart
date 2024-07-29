import 'package:flutter/material.dart';

class NumericChoice extends StatefulWidget {
  const NumericChoice({super.key});

  @override
  State<NumericChoice> createState() => _NumericChoiceState();
}

List<String> songolt = ['10', '8', '6', '4'];
//  List<bool> _isChecked = List<bool>.filled(songolt.length, false);

class _NumericChoiceState extends State<NumericChoice> {
  String currentOption = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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
                      backgroundColor: Colors.black,
                    ),
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
                  ),
                ],
              ),
              Container(
                width: width * 0.9,
                height: height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/eq.png')),
                ),
              ),
              const Text(
                "Энэ зураг танд таалагдаж байна уу ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: songolt.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        songolt[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: Radio(
                        value: songolt[index],
                        groupValue: currentOption,
                        onChanged: (value) {
                          setState(() {
                            currentOption = value.toString();
                          });
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
