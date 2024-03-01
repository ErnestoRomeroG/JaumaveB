import 'package:flutter/material.dart';
import 'package:mave/modelos/events_model.dart';
import 'package:mave/widgets/event_card.dart';
import 'package:mave/widgets/popular_card.dart';
import 'package:mave/widgets/shared/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Usereventos extends StatelessWidget {
  const Usereventos({Key? key}) : super(key: key);

  Future<List<EventModel>> getEventos() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/api/eventos?date=now'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List<dynamic>;
      List<EventModel> events =
          data.map((json) => EventModel.fromJson(json)).toList();
      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventModel>> getSoon() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/api/eventos?date=soon'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List<dynamic>;
      List<EventModel> events =
          data.map((json) => EventModel.fromJson(json)).toList();
      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
          top: 14,
          left: 24,
          right: 24,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Eventos en Jaumave',
                    style: placeholderTextStyle,
                  ),
                  Text(
                    'Esta semana',
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget upcomingEvents() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
            ),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<EventModel>>(
                  future: getEventos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Center(child: Text('Error al cargar datos'));
                    } else {
                      List<EventModel> events = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              events.map((event) => EventCard(event)).toList(),
                        ),
                      );
                    }
                  },
                )),
          )
        ],
      );
    }

    Widget popularNow() {
      return Container(
        margin: const EdgeInsets.only(
          top: 24,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Proximos Eventos',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder<List<EventModel>>(
                    future: getSoon(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return const Center(
                            child: Text('Error al cargar datos'));
                      } else {
                        List<EventModel> events = snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: events
                                .map((event) => PopularCard(event))
                                .toList(),
                          ),
                        );
                      }
                    },
                  )),
            )
          ],
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 212, 255, 242),
      body: SafeArea(
        child: Column(
          children: [
            header(),
            upcomingEvents(),
            popularNow(),
          ],
        ),
      ),
    );
  }
}
