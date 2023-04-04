class AppUser {
  late String? id;
  late String? name;
  late String? email;
  late String? password;
  late String urlProfilePicture;
  late String about;
  static const _url =
      "https://firebasestorage.googleapis.com/v0/b/projetosflutter-c2966.appspot.com/o/perfil%2Fperfil4.png?alt=media&token=0953fe9e-16b8-46a6-8d5d-a38cc6a39574";
  AppUser({
    this.id,
    this.name,
    this.email,
    this.password,
    this.urlProfilePicture = _url,
    this.about = "Disponivel"
  });

  AppUser.map(Map map) {
    id = map["id"];
    name = map["name"];
    email = map["email"];
    urlProfilePicture =
    (map["urlFotoPerfil"] != null) ? map["urlFotoPerfil"] : _url;
    about = map["about"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "urlFotoPerfil": urlProfilePicture,
      "about": about
    };
  }
}
