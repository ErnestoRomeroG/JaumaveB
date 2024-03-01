/* import 'dart:io'; */
import 'package:flutter/material.dart';
/* import 'package:mave/main.dart'; */

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Usercontactos extends StatelessWidget {
  const Usercontactos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Scaffold(
              body: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text(
                          'R. Ayuntamiento de Jaumave Tamaulipas (Conmutador)'),
                      subtitle: Text('Teléfono: (832) 336 0119'),
                      leading: Icon(
                        Icons.location_city,
                        color: Colors.black,
                      ),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "832 336 0119",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('No se pudo realizar la llamada');
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text('Seguridad Estatal'),
                      subtitle: Text('Teléfono: 911'),
                      leading: Icon(
                        Icons.security,
                        color: Colors.black,
                      ),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "911",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('No se pudo realizar la llamada');
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text('Atención Ciudadana'),
                      subtitle: Text('Teléfono: (800) 6333 3333'),
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "8006333333",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('No se pudo realizar la llamada');
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text('Centro de Salud'),
                      subtitle: Text('Teléfono: (832) 336 0129'),
                      leading: Icon(
                        Icons.local_hospital,
                        color: Colors.black,
                      ),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "8323360129",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('No se pudo realizar la llamada');
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text('Denuncia Anónima'),
                      subtitle: Text('Teléfono: 089'),
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "089",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('No se pudo realizar la llamada');
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text('Hospital Integral'),
                      subtitle: Text('Teléfono: (832) 336 1186'),
                      leading: Icon(
                        Icons.local_hospital_sharp,
                        color: Colors.black,
                      ),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "8323361186",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('No se pudo realizar la llamada');
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text('Módulo de Seguridad Pública'),
                      subtitle: Text('Teléfono: (832) 336 0371'),
                      leading: const Icon(
                        Icons.security,
                        color: Colors.black,
                      ),
                      trailing: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "8323360371",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('No se pudo realizar la llamada');
                        }
                      },
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          //shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.black, // <-- Button color
                          foregroundColor: Colors.red, // <-- Splash color
                        ),
                        child: Link(
                            target: LinkTarget.self,
                            uri: Uri.parse("http://www.jaumave.gob.mx/"),
                            builder: (context, followLink) => GestureDetector(
                                  onTap: followLink,
                                  child: Text("Visita la página oficial",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          //fontStyle: FontStyle.,
                                          color: Colors.white)),
                                )
                            //const Icon(Icons.link_sharp , color: Colors.white)
                            ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
