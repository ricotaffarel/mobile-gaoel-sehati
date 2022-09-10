// To parse this JSON data, do
//
//     final RestAbout = restEdukasiFromJson(jsonString);

import 'dart:convert';

RestAbout restAboutFromJson(String str) => RestAbout.fromJson(json.decode(str));

String restAboutToJson(RestAbout data) => json.encode(data.toJson());

class RestAbout {
    RestAbout({
        this.data,
    });

    Data? data;

    factory RestAbout.fromJson(Map<String, dynamic> json) => RestAbout(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.about,
    });

    List<About>? about;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        about: List<About>.from(json["About"].map((x) => About.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "About": List<dynamic>.from(about!.map((x) => x.toJson())),
    };
}

class About {
    About({
        this.id,
        this.judul,
        this.deskripsi,
    });

    int? id;
    String? judul;
    String? deskripsi;

    factory About.fromJson(Map<String, dynamic> json) => About(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "deskripsi": deskripsi,
    };
}
