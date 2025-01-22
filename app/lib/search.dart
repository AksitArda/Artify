import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> history = ['Red Car', 'Space', 'Galaxy', 'Phone', 'Test','Keyvan Arasteh'];

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
              labelText: "Search",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
          ),
          SizedBox(height: 15,),
          ListView.builder(
            itemCount: history.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                child: Padding(padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Öğeler arasına boşluk koyar
                    children: [
                      Text(
                        history[index].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
