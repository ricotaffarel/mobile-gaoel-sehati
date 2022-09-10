// To parse this JSON data, do
//
//     final restKomentar = restKomentarFromJson(jsonString);

import 'dart:convert';

RestKomentar restKomentarFromJson(String str) => RestKomentar.fromJson(json.decode(str));

String restKomentarToJson(RestKomentar data) => json.encode(data.toJson());

class RestKomentar {
    RestKomentar({
        this.data,
    });

    Data? data;

    factory RestKomentar.fromJson(Map<String, dynamic> json) => RestKomentar(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.komentar,
    });

    List<Komentar>? komentar;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        komentar: List<Komentar>.from(json["Komentar"].map((x) => Komentar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Komentar": List<dynamic>.from(komentar!.map((x) => x.toJson())),
    };
}

class Komentar {
    Komentar({
        this.id,
        this.idPost,
        this.idUser,
        this.komen,
    });

    int? id;
    int? idPost;
    int? idUser;
    String? komen;

    factory Komentar.fromJson(Map<String, dynamic> json) => Komentar(
        id: json["id"],
        idPost: json["id_post"],
        idUser: json["id_user"],
        komen: json["komen"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_post": idPost,
        "id_user": idUser,
        "komen": komen,
    };
}
