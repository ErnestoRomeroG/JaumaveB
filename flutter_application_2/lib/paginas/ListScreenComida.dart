import 'package:flutter/material.dart';
import 'package:mave/paginas/negocios.dart';
import 'package:mave/widgets/item.dart';
import 'detailScreenComida.dart';
import 'package:mave/paginas/principal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComidaScreen extends StatefulWidget {
  const ComidaScreen({Key? key, required this.category}) : super(key: key);
  final Categoryy category;

  @override
  State<ComidaScreen> createState() => _ComidaScreenState();
}

class _ComidaScreenState extends State<ComidaScreen> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    getRestaurantes();
  }

  Future<List<dynamic>> getRestaurantes() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/api/post?section=Gastronomía'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    final Future<List<dynamic>> restaurantes = getRestaurantes();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Gastronomia'.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearch(context: context, delegate: NegociosSearchDelegate());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: restaurantes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error al cargar datos'));
          } else {
            //SingleChildScrollView
            return Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: screenWidth / 25),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var restaurante = snapshot.data?[index];
                            return ItemWidget(
                              id: restaurante['_id'],
                              asset: restaurante['image'],
                              title: restaurante['title'],
                              desc: restaurante['details'],
                              fullDesc: restaurante['description'],
                              ubicacion: restaurante['location'],
                              contactos1: restaurante['contact'],
                              onFavoritePressed: () {
                                // Cuando el botón de favoritos es presionado en ItemWidget,
                                // elimina el elemento de la lista y actualiza el estado
                                setState(() {
                                  snapshot.data?.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

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
