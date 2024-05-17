import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management_thesis_app/pages/authentication/web/homePageWebsite.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffold();
}

class _DesktopScaffold extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        // backgroundColor:  Color(0x00000000),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
              Color(0xFFB3E5FC),
              Color(0xFFBA68C8),
              Color(0xFF9576CD),
            ])
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              const Text('PenTools',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30,),
              Container(
                height: 330,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      SizedBox(height: 30,),
                      Text('Hello',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Please Login to Your Account',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                          ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            suffixIcon: Icon(FontAwesomeIcons.envelope,
                            size: 17,)
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(FontAwesomeIcons.eyeSlash,
                            size: 17,)
                          ),
                        ),
                      ),
                      Container(
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
                              context, MaterialPageRoute(builder: (context) => HomePageWebsite())
                            );
                          },
                        ),
                      )
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}