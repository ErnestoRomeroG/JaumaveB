// ignore: file_names
import 'package:flutter/material.dart';
import 'package:mave/paginas/negocios.dart';



class VerEventos extends StatelessWidget {
  const VerEventos({
    super.key,
    required  this.title,
    required this.image,
    required this.description,
    required this.location,
    required this.day,
    required this.month,
    required this.time
  });

  final String title;
  final String image;
  final String description;
  final String location;
  final String day;
  final String month;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        title:  Text(
          'Evento $title '.toUpperCase(),
          style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Montserrat',
              color:  Colors.black,
              fontWeight: FontWeight.bold,
            ),
        ),
        
        backgroundColor:  Colors.white,
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
        body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text( 
                        title.toUpperCase(), 
                        style: const TextStyle(
                          fontSize: 24, 
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(255, 5, 4, 4),
                          fontWeight: FontWeight.w600)
                      ),
                    ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 400,
                          height: 200,
                          child:  Image.network(
                            'http://10.0.2.2:3000/optimize/$image',
                            fit: BoxFit.cover,
                          )
                        ),
                      ),          
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding( 
                        padding: const EdgeInsets.symmetric( vertical: 10),
                            child: Row(children: [

                              const Icon( Icons.location_on, color: Colors.black, size: 20, ),
                              Text( 
                                location.toUpperCase(), 
                                style: const TextStyle(
                                  fontSize: 16, 
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 5, 4, 4),
                                  fontWeight: FontWeight.w600)
                              ),

                              
                              
                            ],)
                        )
                      
                      ),  
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding( 
                        padding: const EdgeInsets.symmetric( vertical: 0),
                            child: Row(children: [

                              const Icon( Icons.schedule_outlined, color: Colors.black, size: 20, ),
                              Text( 
                                '$day $month $time', 
                                style: const TextStyle(
                                  fontSize: 16, 
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 5, 4, 4),
                                  fontWeight: FontWeight.w600)
                              ),

                              
                              
                            ],)
                        )
                      
                      ),            
                      Padding(
                        padding: const EdgeInsets.symmetric( vertical: 5),
                        child: Align(alignment: Alignment.topLeft ,
                          child: Text( description, 
                          style: const TextStyle(
                            
                            fontSize: 16, 
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 5, 4, 4),
                            fontWeight: FontWeight.w400)
                        ),
                        )
                      )
                    ]
                ),
              ),
        )));
  }
}
