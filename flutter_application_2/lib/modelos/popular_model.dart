class PopularModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? isTicket;
  final String? date;
  final String? time;

  PopularModel({
    this.id,
    this.name,
    this.imageUrl,
    this.isTicket,
    this.date,
    this.time,
  });
}

final populars = {
  PopularModel(
    id: 1,
    name: 'Regreso a Talleres',
    date: '31 Augpstp 2023',
    time: '17:00 PM',
    isTicket: 'Prox',
    imageUrl: 'lib/images/7.jpg',
  ),
  PopularModel(
    id: 2,
    name: 'Baile en Grupo, Grupo Traileritos',
    date: '09 September 2023',
    time: '20:00 PM',
    isTicket: 'Prox',
    imageUrl: 'lib/images/21.jpg',
  ),
  PopularModel(
    id: 3,
    name: 'Juegos Tradicionales',
    date: '07 September 2023',
    time: '18:00 PM',
    isTicket: 'Prox',
    imageUrl: 'lib/images/23.jpg',
  ),
  PopularModel(
    id: 4,
    name: 'Encuentro Deportivo Mixto',
    date: '6 September 2023',
    time: '19:00 PM',
    isTicket: 'Prox',
    imageUrl: 'lib/images/24.jpg',
  ),
  PopularModel(
    id: 5,
    name: 'Campamento Familiar',
    date: '9 September 2023',
    time: '17:00 PM',
    isTicket: 'Prox',
    imageUrl: 'lib/images/25.jpg',
  ),
  PopularModel(
    id: 6,
    name: 'Eventos de Comics',
    date: '10 September 2023',
    time: '11:00 am A 19:00 pm ',
    isTicket: 'Prox',
    imageUrl: 'lib/images/28.jpg',
  ),
};
