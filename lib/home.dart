import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List<String> popularImages = [
    'https://via.placeholder.com/200x200?text=Car',
    'https://via.placeholder.com/200x200?text=Nature',
  ];

  final List<String> newImages = [
    'https://via.placeholder.com/200x400?text=Cat',
    'https://via.placeholder.com/200x400?text=Church',
    'https://via.placeholder.com/200x400?text=Church',
    'https://via.placeholder.com/200x400?text=Church',
    'https://via.placeholder.com/200x400?text=Church',
    'https://via.placeholder.com/200x400?text=Church',
    'https://via.placeholder.com/200x400?text=Church',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Section
          Text(
            'Popular',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(popularImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // New Section
          Text(
            'New',
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
