class EventModel {
  final String? id;
  final String? name;
  final String? details;
  final String? location;
  final String? image;
  final String? day;
  final String? month;
  final String? time;

  EventModel({
    this.id,
    this.name,
    this.details,
    this.location,
    this.image,
    this.day,
    this.month,
    this.time
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['_id'],
        name: json['name'],
        details: json['details'],
        location: json['location'],
        image: json['image'],
        day: json['day'],
        month: json['month'],
        time: json['time']
    );
  }
}
/*
final events = [
  EventModel(
    id: '1',
    name: '2 Segundo Informe de Gobierno 2021 - 2024',
    location: 'Teatro del Pueblo',
    imageUrl: 'lib/images/img_event_5.jpg',
    date: '8',
    month: 'Sept',
  ),
  EventModel(
    id: '2',
    name: 'Segunda Dosis y Refuerzo, COVID 19',
    location: 'Centro de Salud',
    imageUrl: 'lib/images/img_event_6.jpg',
    date: '4-16',
    month: 'Sept',
  ),
  EventModel(
    id: '3',
    name: 'Reistro, Academia de futbol Infantil',
    location: 'Teatro del Pueblo',
    imageUrl: 'lib/images/img_event_4.jpg',
    date: '13',
    month: 'Sept',
  ),
  EventModel(
    id: '4',
    name: 'Ven a Celebrar, Grito de indepencia',
    location: 'Plaza Miguel Hidalgo',
    imageUrl: 'lib/images/img_event_2.jpg',
    date: '15',
    month: 'Sept',
  ),
  EventModel(
    id: '5',
    name: 'Ven a Celebrar',
    location: 'Plaza Miguel Hidalgo',
    imageUrl: 'lib/images/img_event_2.jpg',
    date: '15',
    month: 'Sept',
  ),
];
*/