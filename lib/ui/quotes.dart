import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Quotes extends StatefulWidget {
  final String header;

  Quotes({Key key, this.header}) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  Map allData;
  var isLoading = false;

  Future getJoke() async {
    setState(() {
      isLoading = true;
    });

    //API for getting the data
    String apiLink = "http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en";
    print(apiLink);

    http.Response response = await http.get(apiLink);

    if (response.statusCode == 200) {
      allData = jsonDecode(response.body); //JSON.decode in older versions of flutter

      print(allData.toString());

//      data = allData['results'];

//      print(data.toString());

      setState(() {
        isLoading = false;
      });
    }else {
      throw Exception('Failed to load');
    }

  }


  @override
  void initState() {
    super.initState();
    getJoke();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes",
          style: TextStyle(
            color: Colors.green
          ),
        ),
      ),

      body: isLoading
          ? Center(
        child: CircularProgressIndicator(

        ),
      ) : Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Card(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(
                      "${allData["quoteText"]}",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),

                    subtitle: Text("Author: ${allData["quoteAuthor"]}",)

                  ),
                ),
                elevation: 4.0,
              ),


              Container(
                child: RaisedButton(
                  child: Text(
                    "Randomize",
                    style: TextStyle(color: Colors.white,),
                  ),
                  color: Colors.blue,
                  onPressed: (){
                    getJoke();
                  },
                ),
              ),


            ],
          ),
        ),

      )
    );
  }
}
