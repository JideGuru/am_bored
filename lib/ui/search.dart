import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class MySearchDelegate extends SearchDelegate {
  late Map allData;
  late List data;
  var isLoading = false;
  String API_KEY = '427cae42073e49a5829be896c0e82ce3';


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
              "Search term must be longer than 1 letter",
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
          String icon_url = data[position]['urlToImage'];
          String url = data[position]['url'];
          String description = data[position]['description'];
          String title = data[position]['title'];
          print(title);
          return ListTile(
            title: Text("$title"),

            subtitle: Text("$description"),

            leading: CircleAvatar(
//              child: Image.network("$icon_url"),
              backgroundImage: NetworkImage("$icon_url"),
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
    String link = 'https://newsapi.org/v2/top-headlines?q=${query}&apiKey=${API_KEY}';
    print(link);

    http.Response response = await http.get(Uri.parse(link),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      allData = jsonDecode(response.body); //JSON.decode in older versions of flutter

      print(allData.toString());

      data = allData['articles'];

      print(data.toString());


    }else {
      throw Exception('Failed to load');
    }

  }

}