import 'package:flutter/material.dart';
import 'package:mave/paginas/home.dart';
import 'package:mave/widgets/shared/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget customBottomNavbar() {
      return BottomNavigationBar(
        selectedItemColor: orangeColor,
        currentIndex: currentIndex,
        selectedLabelStyle: orangeTextStyle.copyWith(
          fontSize: 10,
          fontWeight: medium,
        ),
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: greyTextStyle.copyWith(
          fontSize: 10,
          fontWeight: medium,
        ),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_home.png',
              width: 24,
              color: currentIndex == 0 ? orangeColor : greyColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_search.png',
              width: 24,
              color: currentIndex == 1 ? orangeColor : greyColor,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_favorite.png',
              width: 24,
              color: currentIndex == 2 ? orangeColor : greyColor,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_ticket.png',
              width: 24,
              color: currentIndex == 3 ? orangeColor : greyColor,
            ),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_profile.png',
              width: 24,
              color: currentIndex == 4 ? orangeColor : greyColor,
            ),
            label: 'Profile',
          ),
        ],
      );
    }

    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: customBottomNavbar(),
    );
  }
}
