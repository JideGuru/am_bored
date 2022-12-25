import 'package:Bored/ui/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';




class Splash extends StatefulWidget {
  final String header;

  Splash({Key? key, required this.header}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void nav(){
    var router = new MaterialPageRoute(
        builder: (BuildContext context) {
          return Home(header: widget.header,);
        }
    );

    Navigator.of(context).push(router);
  }

  var timeout = const Duration(seconds: 3);
  var ms = const Duration(milliseconds: 1);

  startTimeout([int? milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {

    nav();
  }

  @override
  void initState() {
    super.initState();
    startTimeout(5000);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//              Image.asset(
//                "images/icon1.png",
//                height: 150.0,
//                width: 150.0,
//              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 10.0,
//                    bottom: 40.0,
                ),
                child: Text(
                  widget.header,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                  top: 1.0,
                  bottom: 40.0,
                ),
                child: Text(
                  "Get Something to do",
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w100
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
