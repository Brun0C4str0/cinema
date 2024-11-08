class MovieGenre {
  int? id;
  String? name;

  MovieGenre({this.id, this.name});

  MovieGenre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // cria um novo mapa que sera preenchido com os dados da instancia
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
