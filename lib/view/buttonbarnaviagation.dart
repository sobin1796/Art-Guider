import 'package:artguider/res/color.dart';
import 'package:artguider/view/Myartwork.dart/savedwork.dart';
import 'package:artguider/view/homepage/homepage.dart';
import 'package:artguider/view/settings/setting.dart';
import 'package:artguider/viewmodel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Buttonbar extends StatefulWidget {
  const Buttonbar({super.key});

  @override
  State<Buttonbar> createState() => _ButtonbarState();
}

class _ButtonbarState extends State<Buttonbar> {
  static const screenlist = [
    Savedwork(),
    Homepage(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BarnaviProvider>(
      context,
    );
    return Scaffold(
      body: Center(
        child: screenlist.elementAt(provider.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: boxcolor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: boxcolor,
            icon: Image.asset(
              'assets/save.png',
              height: 25,
              width: 25,
              fit: BoxFit.cover,
            ),
            label: 'Saved work',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/house-chimney.png',
              height: 25,
              width: 25,
              fit: BoxFit.cover,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/customize.png',
              height: 25,
              width: 25,
              fit: BoxFit.cover,
            ),
            label: 'settings',
          ),
        ],
        currentIndex: provider.value,
        selectedItemColor: const Color.fromARGB(255, 39, 8, 8),
        onTap: (index) {
          provider.setValue(index);
        },
      ),
    );
  }
}
