import 'package:flutter/material.dart';
import 'package:mave/paginas/acercapage.dart';
import 'package:mave/paginas/infopage.dart';
import 'package:mave/paginas/sugerenciaspage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final Padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    const nameapp = 'AR+';
    const ciudad = 'Jaumave, Tamaulipas';
    const urlImage =
        'https://jaumavetamaulipas.weebly.com/uploads/1/6/8/7/16876174/4009179_orig.jpg';

    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 161, 178, 255),
        child: ListView(
          padding: Padding,
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              nameapp: nameapp,
              ciudad: ciudad,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InfoPage(
                  nameapp: nameapp,
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: Padding,
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  buildMenuItem(
                    text: 'Sobre nosotros',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  buildMenuItem(
                    text: 'Sugerencias',
                    icon: Icons.open_in_new,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const Divider(color: Colors.white70),
                  const Text('Territorio Gorila'),
                  const Text('Derechos Reservados'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String nameapp,
    required String ciudad,
    required VoidCallback onClicked,
  }) =>
      InkWell(
          onTap: onClicked,
          child: Container(
            padding: Padding.add(const EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameapp,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ciudad,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ));

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AcercaPage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SugerenciasPage(),
        ));
    }
  }
}
