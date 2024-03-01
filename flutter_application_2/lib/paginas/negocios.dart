import 'package:flutter/material.dart';
import 'package:mave/paginas/DetailScreenComida.dart';
import '../modelos//Lugares.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class NegociosSearchDelegate extends SearchDelegate {


  List<Lugares> searchResults = [];


  

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/post'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      searchResults = jsonData.map((data) => Lugares.fromJson(data)).toList();
    } else {
        throw Exception('Error al cargar los datos');
    }
  }
  
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.normal),
        ),
      );



@override
Widget buildSuggestions(BuildContext context) {
  fetchData();

  
  List<Lugares> suggestions = searchResults.where((searchResult) {
    final result = searchResult.title.toLowerCase();
    final input = query.toLowerCase();
    return result.contains(input);
  }).toList();

  return ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      final suggestion = suggestions[index];

      /* 
          id: restaurante['_id'],
          asset: restaurante['image'],
          title: restaurante['title'],
          desc: restaurante['details'],
          fullDesc: restaurante['description'],
          ubicacion: restaurante['location'],
          contactos1: restaurante['contact'],

      */

      return ListTile(
        title: Text(suggestion.title),
        onTap: () {
          // Navegación a la pantalla de detalles
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreenComida(
                asset: suggestion.image,
                tag: suggestion.title,
                fullDesc: suggestion.description,
                descoment: suggestion.location,
                contacto1: suggestion.contact,
                /*contacto2: suggestion.contactos2,
                contacto3: suggestion.contactos3,*/
              ),
            ),
          );
        },
      );
    },
  );
}
}