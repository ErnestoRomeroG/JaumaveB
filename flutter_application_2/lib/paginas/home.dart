import 'package:flutter/material.dart';
import 'package:mave/paginas/contactos.dart';
import 'package:mave/paginas/favoritos.dart';
import 'package:mave/paginas/negocios.dart';
import 'package:mave/paginas/principal.dart';
import 'package:mave/paginas/eventos.dart';
import 'package:mave/widgets/navigation_drawer_widget.dart';
//import 'package:mave/widgets/shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Userprincipal(),
    const Usereventos(),
    const Userfavorites(),
    const Usercontactos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: _pages[_selectedIndex],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Jaumave Tamaulipas'.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple,
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
      // ignore: prefer_const_constructors
      drawer: NavigationDrawerWidget(),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(11),
        child: Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(25),
          color: Colors.purple,
          child: Container(
            height: 55,
            width: double.infinity,
            child: ListView.builder(
              itemCount: data.length,
              padding: EdgeInsets.symmetric(horizontal: 19),
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = i;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: 45,
                    decoration: BoxDecoration(
                      border: i == _selectedIndex
                          ? Border(
                              top: BorderSide(width: 4.0, color: Colors.white))
                          : null,
                      gradient: i == _selectedIndex
                          ? LinearGradient(
                              colors: [Colors.white60, Colors.purple],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)
                          : null,
                    ),
                    child: Icon(
                      data[i],
                      size: 30,
                      color: i == _selectedIndex
                          ? Colors.white
                          : Colors.pink.shade200,
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }
}

List<IconData> data = [
  Icons.home,
  Icons.calendar_month,
  Icons.favorite,
  Icons.call,
];

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Drawer(
        child: Icon(Icons.menu_book_rounded),
      );
}
