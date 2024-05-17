import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/pages/authentication/mobile/homePageMobile.dart';


class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State <MobileScaffold> createState() =>  MobileScaffoldState();
}

class  MobileScaffoldState extends State <MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(
        title: Text('Mobiles Authentication Page')),
        body: Container(
                        margin: EdgeInsets.only(top:20),
                        width: 150,
                        child: ElevatedButton(child: Text("Log In",
                        style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w200),),
                        style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              elevation: 0,
                          ),
                        
                          onPressed: () {
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => homepageMobile())
                            );
                          },
                        ),
                      ),
    );
  }
}