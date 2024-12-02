import 'package:artify/main.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> newImages = [
      'https://via.placeholder.com/200x400?text=Cat',
      'https://via.placeholder.com/200x400?text=Church',
      'https://via.placeholder.com/200x400?text=Church',
      'https://via.placeholder.com/200x400?text=Church',
      'https://via.placeholder.com/200x400?text=Church',
      'https://via.placeholder.com/200x400?text=Church',
      'https://via.placeholder.com/200x400?text=Church',
    ];

    return SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Section
          Text(
            'Favorites',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: newImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(newImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),);
  }
}
