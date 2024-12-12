import 'package:artify/main.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> newImages = [
      'https://images.unsplash.com/photo-1571513151379-9612cf354937?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1733592688551-5ba7804a9634?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1732200584655-3511db5c24e2?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1487260211189-670c54da558d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-169994-674010.jpg&fm=jpg'
    ];

    return SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(15.0), //Ekran kenarından yan boşlukları ayarlama
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Section
          Row(children: [Text(  //Favori Başlık kodu Row=Yatay Sıralama
            'Favorites',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),SizedBox(width: 4,), //Favorite ile ikon arasındaki boşluk
            Icon(Icons.favorite, color:Colors.deepPurple,),],),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), //Izgaranın Kaydırılması
            itemCount: newImages.length, //kaç item olacağı
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Ekrana yan yana kaç adet fotoğraf sığdırma
              crossAxisSpacing: 10, //fotoğraflar arası yan boşluk
              mainAxisSpacing: 10, //fotoğraflar arası alt boşluk
            ),
            itemBuilder: (context, index) {
              return Container( //kutu widgeti
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), //kenar yumuşatma
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