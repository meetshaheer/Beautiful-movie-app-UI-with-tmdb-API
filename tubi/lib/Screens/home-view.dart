import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tubi/API%20Services/api-model.dart';
import 'package:tubi/API%20Services/api-service.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  API_Service apiservice = API_Service();
  final String baseurl = "https://api.themoviedb.org/3/movie/popular?api_key=6ee85343f0516bb3cccc88b483019033";
 

  List<Movie_Model> resposedata = [];

  Future<List<dynamic>> getApi() async {
    resposedata.clear();
    var url = Uri.parse(baseurl);
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    responsebody = responsebody['results'];
    for (var eachMap in responsebody) {
      resposedata.add(Movie_Model.fromJson(eachMap));
    }
    print(resposedata);
    return resposedata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tubi"),
      ),
      body: FutureBuilder(
        future: getApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: resposedata.length,
                itemBuilder: (context, index) {
                  var data = resposedata[index];
                  return ListTile(title: Text(data.title ?? ""));
                });
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
