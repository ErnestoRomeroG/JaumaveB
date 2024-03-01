


class Like {

    String id;
    String asset;
    String title;
    String desc;
    String fullDesc;
    String ubicacion;
    String contactos1;


    Like(this.id, this.asset, this.title, this.desc, this.fullDesc, this.ubicacion, this.contactos1);

    factory Like.fromJson(Map<String, dynamic> json){
        return Like(json['id'] , json['asset'], json['title'], json['desc'], json['fullDesc'], json['ubicacion'], json['contactos1']);
    }

    Map<String, dynamic> toJson() => {
      'id': id,
      'asset': asset,
      'title': title,
      'desc': desc,
      'fullDesc': fullDesc,
      'ubicacion': ubicacion,
      'contactos1': contactos1,
    };
}