import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mave/modelos/categoriamodel.dart';
import 'package:mave/paginas/ListScreenArtesanias.dart';
import 'package:mave/paginas/ListScreenComida.dart';
import 'package:mave/paginas/ListScreenTurismo.dart';
import 'package:mave/paginas/ListscreenHospedaje.dart';
import 'package:mave/paginas/ListscreenLugares.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categoryy {
  final String id;
  final String title;
  final String image;
  final TextStyle textStyle;
  final Color color;

  final ScrollController scrollController;

  Categoryy(
      {required this.id,
      required this.title,
      required this.image,
      required this.textStyle,
      required this.color})
      : scrollController = ScrollController();
}

class Userprincipal extends StatelessWidget {
  final List<Categoryy> categoriies = [
    Categoryy(
      id: '1',
      title: 'Hospedaje',
      image: 'lib/images/hospedaje.png',
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      color: Colors.blue,
    ),
    Categoryy(
      id: '2',
      title: 'Gastronomia',
      image: 'lib/images/restaurant.png',
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      color: Colors.blue,
    ),
    Categoryy(
      id: '3',
      title: 'Biodiversidad',
      image: 'lib/images/biodiversidad.png',
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      color: Colors.blue,
    ),
    Categoryy(
      id: '4',
      title: 'Artesanos',
      image: 'lib/images/artesanos.png',
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      color: Colors.blue,
    ),
    Categoryy(
      id: '5',
      title: 'Atractivos\nTurísticos',
      image: 'lib/images/emblematicos.png',
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      color: Colors.blue,
    ),
    // Agrega más categorías sea necesario
  ];

  Future<List<Category>> getTrending() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/api/post?trending=true'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List<dynamic>;
      List<Category> events =
          data.map((json) => Category.fromJson(json)).toList();
      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Userprincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<List<dynamic>> trending = getTrending();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 255, 242),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: SizedBox(
                child: Text(
                  'Destacados',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: trending,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const SizedBox(
                      height: 250,
                      child: Center(
                        child: Text('Error al cargar datos'),
                      ));
                } else {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                    ),
                    items: snapshot.data!
                        .map<Widget>((item) => HeroCarouselCard(category: item))
                        .toList(),
                  );
                }
              }),
          const SizedBox(
            height: 5.0,
          ),

          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal:
                      15), // Ajusta los valores según el espacio que desees agregar

              child: SizedBox(
                child: Text(
                  '¿A dónde quieres ir?',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriies.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                HospedajeScreen(category: categoriies[index])),
                      );
                    } else if (index == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ComidaScreen(category: categoriies[index])),
                      );
                    } else if (index == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                LugaresScreen(category: categoriies[index])),
                      );
                    } else if (index == 3) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ArtesaniaScreen(category: categoriies[index])),
                      );
                    } else if (index == 4) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                TurismoScreen(category: categoriies[index])),
                      );
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 12, bottom: 8, top: 8),
                    child: Material(
                      elevation: 3,
                      color: Color.fromARGB(255, 253, 199, 167),
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.black,
                      child: SizedBox(
                        height: 100,
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              categoriies[index].image,
                              width: 52,
                              height: 52,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              categoriies[index].title,
                              style: categoriies[index].textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 28),
          // Aquí añadimos la imagen debajo de las categorías
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 105,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      'http://www.jaumave.gob.mx/wp-content/uploads/sites/13/2022/05/slider_jaumave_2400x600-04-850x300.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey[300] ?? Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroCarouselCard extends StatelessWidget {
  final Category category;
  const HeroCarouselCard({
    super.key,
    required this.category,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 20,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: Stack(
          children: <Widget>[
            Image.network(
              "http://10.0.2.2:3000/optimize/${category.imageUrl}",
              fit: BoxFit.cover,
              width: 1000.0,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  category.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
