import 'package:flutter/material.dart';
import 'package:flutter_prayer_times/kiblat.dart';
import 'package:flutter_prayer_times/jadwal.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _selectedindex = 0;
  final _screens = [
    jadwal(),
    kiblat()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black26,
        currentIndex: _selectedindex,
        onTap: (index){
          setState(() {
            _selectedindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), 
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Home'), 
        ],
        ),
    );
  }
}