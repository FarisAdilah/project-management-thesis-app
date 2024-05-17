import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/pages/constrant.dart';


class homepageMobile extends StatefulWidget {
  const homepageMobile({super.key});

  @override
  State<homepageMobile> createState() => _homepageMobileState();
}

class _homepageMobileState extends State<homepageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackground,
      appBar: defaultAppBar,
      drawer: defaultDrawer,
    );
  }
}