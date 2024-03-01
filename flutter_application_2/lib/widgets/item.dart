import 'package:flutter/material.dart';
import 'package:mave/modelos/like.dart';
import 'package:mave/paginas/DetailScreenComida.dart';
import 'package:mave/shared/Likes.dart';


class ItemWidget extends StatefulWidget {

    final String id;
    final String asset;
    final String title;
    final String desc;
    final String fullDesc;
    final String ubicacion;
    final String contactos1;
    final String contactos2;
    final String contactos3;
    final bool isFavorite;
    final VoidCallback onFavoritePressed;
    const ItemWidget({super.key, 
        required this.id,
        required this.asset,
        required this.title,
        required this.desc,
        required this.fullDesc,
        required this.ubicacion,
        required this.contactos1,
        this.contactos2 = "",
        this.contactos3 = "",
        this.isFavorite = false,
        required this.onFavoritePressed
    });

    @override
    ItemWidgetState createState() => ItemWidgetState();

}

class ItemWidgetState  extends State<ItemWidget>  {

    bool favorite = false;

    @override
    void initState() {
        super.initState();

        favorite = widget.isFavorite;

        Likes likes = Likes();
        likes.loadLikes().then((value) {
            likes.isLiked(widget.id).then((value) {
                setState(() {
                    favorite = value;
                });
            });
        });
    }


    @override
    Widget build(BuildContext context) {

        String asset = widget.asset;
        String title = widget.title;
        String desc = widget.desc;
        String fullDesc = widget.fullDesc;
        String ubicacion = widget.ubicacion;
        String contactos1 = widget.contactos1;
        String contactos2 = widget.contactos2;
        String contactos3 = widget.contactos3;
        
        void toggleFavorite(bool isFavorite) {

            Likes like = Likes();
            if(isFavorite == false) {
                like.removeLikeById(widget.id);
                widget.onFavoritePressed();
                return;
            }

            Like fav = Like(widget.id, widget.asset, widget.title, widget.desc, widget.fullDesc, widget.ubicacion, widget.contactos1);
            like.addLike(fav) ;
            setState(() {
                favorite = true;
            });
            
        }

        final screenWidth = MediaQuery.of(context).size.width;
        return GestureDetector(
            onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => DetailScreenComida(
                    asset: asset,
                    tag: title,
                    fullDesc: fullDesc,
                    descoment: ubicacion,
                    contacto1: contactos1,
                    contacto2: contactos2,
                    contacto3: contactos3,
                    ),
                ),
                );
            },
            child: Container(
                height: screenWidth / 2.8,
                width: screenWidth,
                margin: EdgeInsets.only(
                bottom: screenWidth / 20,
                ),
                child: Row(
                children: [
                    Hero(
                    tag: title,
                    child: Container(
                        width: screenWidth / 2.8,
                        height: screenWidth / 2.8,
                        margin: EdgeInsets.only(
                            right: screenWidth / 20,
                        ),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            "http://10.0.2.2:3000/optimize/$asset",
                            fit: BoxFit.cover,
                        ),
                        ),
                    ),
                    ),
                    Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    title,
                                    style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    fontSize: 20,
                                    ),
                                ),
                                Text(
                                    desc,
                                    style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontSize: 14,
                                    ),
                                ),
                                
                            ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                                IconButton( 

                                    icon: Icon(
                                        favorite ? Icons.favorite : Icons.favorite_border,
                                        color: favorite ? Colors.red : null,
                                    ),
                                    onPressed: () { 
                                        toggleFavorite(!favorite);
                                    },  
                                )
                            ],
                        )
                        /*const Text(
                            "In Stock",
                            style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                            fontSize: 20,
                            ),
                        ),*/
                        ],
                    ),
                    ),
                ],
                ),
            ),
        );
    }


    

    /* 
        String id;
    String title;
    Object section;
    String description;
    String image;
    String details;
    String location;
    bool multilocation;
    String contact;
    
    */
}
