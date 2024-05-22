import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


var defaultBackground = Colors.grey[300];

var defaultAppBar = AppBar(
  backgroundColor: Colors.grey[900],
);

var defaultDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  
  
  child: Column(children: [
    DrawerHeader(child: Icon(FontAwesomeIcons.image)),
    ListTile(
        leading: Icon(FontAwesomeIcons.home),
        title: Text('Dashboard PenTools'),
    ),
    ListTile(
      leading: Icon(FontAwesomeIcons.user),
      title: Text('List Staff'),
    )
  ],),
);