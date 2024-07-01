import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingleChoice extends StatefulWidget {
  SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

List<String> options = ['Options 1 ', 'Options 2', 'Options 3 '];

class _SingleChoiceState extends State<SingleChoice> {
  String currentOption = options[0];
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
            icon: Icon(Icons.home),
            onPressed: () {},
            color: Color(0xff910A67),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.only(right: 20, left: 10),
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
                        padding: EdgeInsets.symmetric(horizontal: 0),
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
                  Text(
                    "1/3 2",
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
              ListTile(
                title: Text("options 1", style: TextStyle(color: Colors.white)),
                leading: Radio(
                  value: options[0],
                  groupValue: currentOption,
                  onChanged: (value) {
                    setState(() {
                      currentOption = value.toString();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Options 2",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Radio(
                  value: options[1],
                  groupValue: currentOption,
                  onChanged: (value) {
                    setState(() {
                      currentOption = value.toString();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "options 3",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Radio(
                  value: options[2],
                  groupValue: currentOption,
                  onChanged: (value) {
                    setState(() {
                      currentOption = value.toString();
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
