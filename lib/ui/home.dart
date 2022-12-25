import 'package:Bored/ui/jokes.dart';
import 'package:Bored/ui/quotes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String header;

  Home({Key? key, required this.header}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

//      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.header}",
          style: TextStyle(
            color: Colors.red
          ),
        ),
//        backgroundColor: Colors.black45,
        automaticallyImplyLeading: false,

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.red,
            ),
            onPressed: () {
              debugPrint("Tapped");
            },
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  "Are You Bored? choose an Activity below:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 17.0
                  ),
                ),
              ),
              Divider(),
              
              ListTile(
                title: Text("Jokes"),
                subtitle: Text("Read Random funny jokes from around the net"),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("😂"),
                ),
                onTap: (){
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Jokes(header: widget.header,);
                      }
                  );

                  Navigator.of(context).push(router);
                },
              ),
              
              Divider(),

              ListTile(
                title: Text("Inspirational Quotes"),
                subtitle: Text("Get inspires with cool quotes from top QUOTERS😂"),
//                leading: CircleAvatar(
//                  backgroundColor: Colors.green,
//                  child: Text("😀"),
//                ),
//
                trailing: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text("😀")
                ),
                onTap: (){
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Quotes(header: widget.header,);
                      }
                  );

                  Navigator.of(context).push(router);
                },
              ),

              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
