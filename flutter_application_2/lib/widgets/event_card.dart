import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mave/modelos/Ver_Eventos.dart';
import 'package:mave/modelos/events_model.dart';

import 'package:mave/widgets/shared/theme.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  const EventCard(
    this.event, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 262,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 18),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 176,
                height: 117,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage( "http://10.0.2.2:3000/optimize/${event.image!}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SizedBox(
                  height: 34,
                  width: 34,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 18,
                        sigmaY: 18,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor.withOpacity(0.2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              event.day!,
                              style: whiteTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              event.month!,
                              style: whiteTextStyle.copyWith(
                                fontSize: 8,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(
            height: 10,
          ),
          Text(
            event.name!,
            style: primaryTextStyle.copyWith(
              fontWeight: semiBold,
            ),
          ),
          
          const SizedBox(
            height: 5,
          ),
          
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 12,
                color: Colors.red,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                event.location!,
                style: greyTextStyle,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                size: 12,
                color: Colors.red,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '${event.day!} ${event.month!} • ${event.time!}',
                style: greyTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          
          SizedBox(
            width: double.infinity,
            height: 33,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerEventos(
                      title: event.name!,
                      image: event.image!,
                      description: event.details!,
                      location: event.location!,
                      day: event.day!,
                      month: event.month!,
                      time: event.time!,

                    )));
              },
              style: TextButton.styleFrom(
                backgroundColor: orangeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Ver',
                style: whiteTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
