import 'package:flutter/material.dart';
import 'package:mave/paginas/negocios.dart';
import 'package:url_launcher/link.dart';

class SugerenciasPage extends StatelessWidget {
  const SugerenciasPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Sugerencias'.toUpperCase(),
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
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: const ListTile(
              title: Text(
                  'Para mayores sugerencias ingrese a nuestra pagina oficial, donde podras ver más contenido de Jaumave Tamaulipas:'),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(30),
              backgroundColor: Colors.black, // <-- Button color
              foregroundColor: Colors.blue, // <-- Splash color
            ),
            child: Link(
                target: LinkTarget.self,
                uri: Uri.parse("http://www.jaumave.gob.mx/contacto/"),
                builder: (context, followLink) => GestureDetector(
                      onTap: followLink,
                      child: const Icon(Icons.link_sharp, color: Colors.white),
                    )
                //const Icon(Icons.link_sharp , color: Colors.white)
                ),
          )
        ],
      ));
}
