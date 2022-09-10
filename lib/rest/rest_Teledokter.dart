// To parse this JSON data, do
//
//     final restTeledokter = restTeledokterFromJson(jsonString);

import 'dart:convert';

RestTeledokter restTeledokterFromJson(String str) => RestTeledokter.fromJson(json.decode(str));

String restTeledokterToJson(RestTeledokter data) => json.encode(data.toJson());

class RestTeledokter {
    RestTeledokter({
        this.data,
    });

    Dataa? data;

    factory RestTeledokter.fromJson(Map<String, dynamic> json) => RestTeledokter(
        data: Dataa.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Dataa {
    Dataa({
        this.teledokter,
    });

    List<Teledokter>? teledokter;

    factory Dataa.fromJson(Map<String, dynamic> json) => Dataa(
        teledokter: List<Teledokter>.from(json["Teledokter"].map((x) => Teledokter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Teledokter": List<dynamic>.from(teledokter!.map((x) => x.toJson())),
    };
}

class Teledokter {
    Teledokter({
        this.id,
        this.nama,
        this.photo,
        this.link,
    });

    int? id;
    String? nama;
    String? photo;
    String? link;

    factory Teledokter.fromJson(Map<String, dynamic> json) => Teledokter(
        id: json["id"],
        nama: json["nama"],
        photo: json["photo"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "photo": photo,
        "link": link,
    };
}
