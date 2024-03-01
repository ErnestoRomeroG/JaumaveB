import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final String nameapp;
  final String urlImage;

  const InfoPage({
    // ignore: non_constant_identifier_names
    Key? Key,
    required this.nameapp,
    required this.urlImage,
  }) : super(key: Key);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(nameapp),
          centerTitle: true,
        ),
        body: Image.network(
          urlImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
}
