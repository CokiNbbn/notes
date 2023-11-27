import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/task_detail_page.dart';

class AboutDeveloperPage extends StatelessWidget {
  const AboutDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About Developer',
          style: MyStyle.titleStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            width: double.maxFinite,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ClipOval(
                    child: Image(
                  image: AssetImage('assets/images/profil.jpg'),
                )),
                const SizedBox(
                  height: 20.0,
                ),
                const Center(
                  child: Text(
                    'Coki Rofin Martogi Nababan',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  'Information Systems Student at Universitas Airlangga',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black54,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 150.0,
                ),
                const Text(
                  'Contact Me',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                    fontSize: 14.0,
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      FontAwesomeIcons.linkedin,
                      size: 12.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Coki Rofin Martogi Nababan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      FontAwesomeIcons.envelope,
                      size: 12.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'cokynababan28@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
