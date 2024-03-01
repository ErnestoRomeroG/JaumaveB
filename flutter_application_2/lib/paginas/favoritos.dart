import 'package:flutter/material.dart';

import 'package:mave/modelos/like.dart';
import 'package:mave/paginas/DetailScreenComida.dart';
import 'package:mave/shared/Likes.dart';
import 'package:mave/widgets/item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Userfavorites extends StatelessWidget {
  const Userfavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FavoriteList(),
    );
  }
}

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  FavoriteListState createState() => FavoriteListState();
}

class FavoriteListState extends State<FavoriteList> {
  List<dynamic> items = [];

  double screenWidth = 0;
  double screenHeight = 0;

  FavoriteListState();

  Likes likes = Likes();

  @override
  void initState() {
    super.initState();
    loadLikes();
  }

  Future<void> loadLikes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? likesJson = prefs.getString('likes');

    if (likesJson != null) {
      List<dynamic> likesList = json.decode(likesJson);
      items = likesList.map((likeJson) => Like.fromJson(likeJson)).toList();
    }

    setState(() {});
  }

  List<String> favoriteItems = [];

  void toggleFavorite(String item) {
    setState(() {
      if (favoriteItems.contains(item)) {
        favoriteItems.remove(item);
      } else {
        favoriteItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 212, 255, 242),
        body: SafeArea(
          child: items.isNotEmpty
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final Like item = items[index];
                    //final isFavorite = favoriteItems.contains(item);

                    return SingleChildScrollView(
                      child: SafeArea(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: screenWidth / 25),
                        child: Column(
                          children: [
                            ItemWidget(
                              id: item.id,
                              asset: item.asset,
                              title: item.title,
                              desc: item.desc,
                              fullDesc: item.fullDesc,
                              ubicacion: item.ubicacion,
                              contactos1: item.contactos1,
                              isFavorite: true,
                              onFavoritePressed: () async {
                                // Cuando el botón de favoritos es presionado en ItemWidget,
                                // elimina el elemento de la lista y actualiza el estado
                                setState(() {
                                  items.removeAt(index);
                                  likes.loadLikes();
                                  //items.removeWhere((o) => o.id == item.id);
                                });
                              },
                            )
                          ],
                        ),
                      )),
                    );
                  })
              : const Center(
                  child: Text(
                    'No tienes favoritos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ));
  }

/* 
  child: ItemWidget(
                        id: item.id, 
                        asset: item.asset, 
                        title: item.title, 
                        desc: item.desc, 
                        fullDesc: item.fullDesc, 
                        ubicacion: item.ubicacion, 
                        contactos1: item.contactos1);
              },

*/

  Widget item(
      String asset,
      String title,
      String desc,
      String fullDesc,
      String ubicacion,
      String contactos1,
      String contactos2,
      String contactos3) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreenComida(
              asset: asset,
              tag: title,
              fullDesc: fullDesc,
              descoment: ubicacion,
              contacto1: contactos1,
              contacto2: contactos2,
              contacto3: contactos3,
            ),
          ),
        );
      },
      child: Container(
        height: screenWidth / 2.8,
        width: screenWidth,
        margin: EdgeInsets.only(
          bottom: screenWidth / 20,
        ),
        child: Row(
          children: [
            Hero(
              tag: title,
              child: Container(
                width: screenWidth / 2.8,
                height: screenWidth / 2.8,
                margin: EdgeInsets.only(
                  right: screenWidth / 20,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "http://10.0.2.2:3000/optimize/$asset",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        desc,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  /*const Text(
                          "In Stock",
                          style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontSize: 20,
                          ),
                      ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
