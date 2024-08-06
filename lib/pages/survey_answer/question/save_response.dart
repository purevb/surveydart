import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SaveResponse extends StatefulWidget {
  const SaveResponse({super.key});

  @override
  State<SaveResponse> createState() => SaveResponseState();
}

class SaveResponseState extends State<SaveResponse> {
  late String email;
  String? name;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int currentIndex = 0;
    return Scaffold(
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: const Color.fromARGB(255, 184, 169, 236),
        tabBackgroundColor: Colors.black.withOpacity(0.2),
        padding: const EdgeInsets.all(15),
        tabMargin: const EdgeInsets.only(bottom: 4, right: 14, left: 14),
        selectedIndex: currentIndex,
        // onTabChange: (index) {
        //   setState(() {
        //     currentIndex = index;
        //   });
        // },
        gap: 0,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Likes',
          ),
          GButton(
            icon: Icons.search_sharp,
            text: 'Search',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 187, 178, 202), Color(0xffe7e2fe)],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 57, 16, 122),
                  Color.fromARGB(255, 183, 170, 241)
                ],
              ),
            ),
          ),
          Positioned(
            top: -80,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 57, 16, 122),
                    Color.fromARGB(255, 218, 196, 243)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.18,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              width: width,
              height: height * 0.6,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.amber,
                      padding: const EdgeInsets.all(25),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "sadas",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: height * 0.8,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Save Button")),
          ),
          Positioned(
            top: height * 0.04,
            left: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: height * 0.04,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.storm,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
