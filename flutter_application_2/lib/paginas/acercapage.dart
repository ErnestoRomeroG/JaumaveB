import 'package:flutter/material.dart';

class AcercaPage extends StatelessWidget {
  const AcercaPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Acerca de'.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Jaumave es un municipio de Tamaulipas en nuestro país México, ubicada en el suroeste del estado y es cabecera del municipio del mismo nombre, es uno de los 43 municipios en que se encuentra dividido el estado mexicano de Tamaulipas, se caracteriza por abarca una gran extensión de la Sierra Madre Oriental.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'El problema a identificar como turista, es que no siempre se tendrá una guía turística en un viaje, agregando que se maneja un cobro extra en cada lugar turístico. Además, que en circunstancias no encontrara o se le dificultara entender donde se encuentra.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Creadores del Proyecto",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "1 - Jose Francisco Olivo Hernandez\n2- Jesus Ernetso Romero Garcia\n3 - José Arturo Villanueva González\n4- Eleazar José Quiroga Reyes\n5- Edson Luciano Martinez Torrez ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ));
}
