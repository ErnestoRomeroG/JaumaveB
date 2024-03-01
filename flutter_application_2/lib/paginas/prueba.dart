import 'package:flutter/material.dart';

class Categoria1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Categoria 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Estás viendo los detalles de la Categoría 1',
              style: TextStyle(fontSize: 18),
            ),
            // Agrega otros widgets y contenido relacionado con la categoría aquí
          ],
        ),
      ),
    );
  }
}
