import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
          if (snapshot.connectionState == ConnectionState.done) {
            return CarouselSlider(
              items: resposedata.map((movie) {
                return Builder(builder: (BuildContext context) {
                  return Container();
                });
              }).toList(),
              options: CarouselOptions(),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

// items: resposedata.map((movie) {
//   return Builder(
//     builder: (BuildContext context) {
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         margin: const EdgeInsets.symmetric(horizontal: 5.0),
//         decoration: BoxDecoration(
//           color: Colors.amber,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Display the movie poster using the poster path
//             Image.network(
//               'https://image.tmdb.org/t/p/w500${movie.posterPath}', // This accesses the posterPath field of the movie
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: 300, // Adjust height as needed
//             ),
//             SizedBox(height: 10),
//             Text(
//               movie.title, // Accesses the title field of the movie
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Text(movie.overview, textAlign: TextAlign.center), // Accesses the overview field of the movie
//           ],
//         ),
//       );
//     },
//   );
// }).toList(),
