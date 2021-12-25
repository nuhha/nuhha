import 'package:flutter/material.dart';
import 'package:resep_makanan/views/widget/resep_card.dart';

class DetailResep extends StatelessWidget {
  final String name;
  final String images;
  final String rating;
  final String totalTime;
  final String description;

  DetailResep({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Resep Makanan')
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ResepCard(
                  title: name,
                  cookTime: totalTime,
                  rating: rating,
                  thumbnailUrl: images),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                    Text(description,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
