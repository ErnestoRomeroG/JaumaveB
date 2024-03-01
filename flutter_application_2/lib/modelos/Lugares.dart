// ignore_for_file: file_names

class Lugares {
    String id;
    String title;
    Object section;
    String description;
    String image;
    String details;
    String location;//
    bool multilocation;
    String contact;

    Lugares(this.id, this.title, this.section, this.description, this.image, this.details, this.location, this.multilocation, this.contact);

    factory Lugares.fromJson(Map<String, dynamic> json){
        return Lugares(json['_id'] , json['title'], json['section'], json['description'], json['image'], json['details'], json['location'], json['multilocation'], json['contact']);
    }

    Map<String, dynamic> toJson() => {
      'id': id,
      'title': title,
      'section': section,
      'description': description,
      'image': image,
      'details': details,
      'location': location,
      'multilocation': multilocation,
      'contact': contact,
    };

}