import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor:  Color(0x00000000),
      ),
      body: SingleChildScrollView(
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
              const SizedBox(height: 50,),
              const Text('PenTools',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30,),
              Container(
                height: 480,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Column(
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
                          fontSize: 10,
                          fontWeight: FontWeight.normal
                          ),
                      ),
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
