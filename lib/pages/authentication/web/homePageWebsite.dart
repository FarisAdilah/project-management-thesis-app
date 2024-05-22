import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageWebsite extends StatefulWidget {
  const HomePageWebsite({super.key});

  @override
  State<HomePageWebsite> createState() => _HomePageWebsiteState();
}

class _HomePageWebsiteState extends State<HomePageWebsite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        child: const Column(children: [
          SizedBox(height: 20,),
          Text("Test")
        ],),
      ),
    );
  }
}
