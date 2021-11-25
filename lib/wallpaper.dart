import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Wallpaper extends StatefulWidget {
  const Wallpaper({Key? key}) : super(key: key);



  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List image = [];
  @override
  void initState(){
    super.initState();
    fetchAPI();
  }

  fetchAPI() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
          '563492ad6f91700001000001c73e778870794224b1ddf8edefb911de'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        image = result['photos'];
      });
      print(image[0]);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: 80,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image[index]['url']),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.black,
            child: Center(
              child: GestureDetector(
                onTap: (){
                  print("hi");
                  fetchAPI();
                },
                child: Text(
                  "Load More",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
