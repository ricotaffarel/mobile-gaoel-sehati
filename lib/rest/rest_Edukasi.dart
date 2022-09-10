// To parse this JSON data, do
//
//     final restEdukasi = restEdukasiFromJson(jsonString);

import 'dart:convert';

RestEdukasi restEdukasiFromJson(String str) => RestEdukasi.fromJson(json.decode(str));

String restEdukasiToJson(RestEdukasi data) => json.encode(data.toJson());

class RestEdukasi {
    RestEdukasi({
        this.data,
    });

    Data? data;

    factory RestEdukasi.fromJson(Map<String, dynamic> json) => RestEdukasi(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.edukasi,
    });

    List<Edukasi>? edukasi;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        edukasi: List<Edukasi>.from(json["Edukasi"].map((x) => Edukasi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Edukasi": List<dynamic>.from(edukasi!.map((x) => x.toJson())),
    };
}

class Edukasi {
    Edukasi({
        this.id,
        this.judul,
        this.deskripsi,
    });

    int? id;
    String? judul;
    String? deskripsi;

    factory Edukasi.fromJson(Map<String, dynamic> json) => Edukasi(
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
