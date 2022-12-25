import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class MySearchDelegate extends SearchDelegate {
  late Map allData;
  late List data;
  var isLoading = false;

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than 1 letters.",
            ),
          )
        ],
      );
    }


    return Container(
      child: ListView.separated(
        itemCount: data == null ? 0 : data.length,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int position) {
          String icon_url = data[position]['icon_url'];
          String value = data[position]['value'];
          String id = data[position]['id'];
          print(id);
          return ListTile(
            title: Text("$id"),

            subtitle: Text("$value"),

            leading: CircleAvatar(
              child: Image.network("$icon_url"),
            ),

//            onTap: (){
//              _showAlertMessage(context, fullname, message);
//            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getJokes();
    return Column();
  }

  Future getJokes() async {

    //API for getting the data
    String link = "https://api.chucknorris.io/jokes/search?query=$query";
    print(link);

    http.Response response = await http.get(Uri.parse(link),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      allData = jsonDecode(response.body); //JSON.decode in older versions of flutter

//      print(allData.toString());

      data = allData['result'];

      print(data.toString());


    }else {
      throw Exception('Failed to load');
    }

  }

}