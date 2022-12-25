import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Bored/ui/search.dart';
import 'dart:async';
import 'dart:convert';


class Jokes extends StatefulWidget {

  final String header;

  Jokes({Key? key, required this.header}) : super(key: key);
  @override
  _JokesState createState() => _JokesState();
}

class _JokesState extends State<Jokes> {

  late Map allData;
  late List data;
  late String joke;
  late String id;
  var isLoading = false;


  Future getJoke() async {
    setState(() {
      isLoading = true;
    });

    //API for getting the data
    String apiLink = "https://icanhazdadjoke.com/";
    print(apiLink);

    http.Response response = await http.get(Uri.parse(apiLink),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      allData = jsonDecode(response.body); //JSON.decode in older versions of flutter

      print(allData.toString());

      joke = allData['joke'];
      id = allData['id'];
      print(joke);
      print(id);
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
//        centerTitle: true,
        title: Text(
          "Jokes",
          style: TextStyle(
              color: Colors.blue
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon:Icon(
                Icons.search,
                color: Colors.blue,
              ),
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              }
          )
        ],
      ),

      body: isLoading
          ? Center(
        child: CircularProgressIndicator(

        ),
      )
          :Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Container(
                child: Image.network("https://icanhazdadjoke.com/j/$id.png"),
              ),
              
              Card(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("$joke", style: TextStyle(fontSize: 17.0,),),
                ),
                elevation: 4.0,
              ),


              Container(
                child: ElevatedButton(
                  child: Text(
                    "Randomize",
                    style: TextStyle(color: Colors.white,),
                  ),
                  // color: Colors.blue,
                  onPressed: (){
                    getJoke();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
