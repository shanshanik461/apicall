import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'album_model.dart';

class Page_1 extends StatefulWidget {
  const Page_1({super.key});

  @override
  State<Page_1> createState() => _Page_1State();
}

class _Page_1State extends State<Page_1> {
  late Future<AlbumModel> ameerVeriabl;

  Future<AlbumModel> ameer() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/6"));
    if (response.statusCode == 200) {
      return AlbumModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('ameer failed');
    }
  }

  @override
  void initState() {
    super.initState();
    ameerVeriabl = ameer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: ameer(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("error");
            }
            if (snapshot.hasData) {
              return Text(snapshot.data?.title ?? "Null");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
