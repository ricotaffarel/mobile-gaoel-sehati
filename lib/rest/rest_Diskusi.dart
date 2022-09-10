// To parse this JSON data, do
//
//     final RestDiskusi = restEdukasiFromJson(jsonString);

import 'dart:convert';

RestDiskusi restDiskusiFromJson(String str) => RestDiskusi.fromJson(json.decode(str));

String restDiskusiToJson(RestDiskusi data) => json.encode(data.toJson());

class RestDiskusi {
    RestDiskusi({
        this.data,
    });

    Data? data;

    factory RestDiskusi.fromJson(Map<String, dynamic> json) => RestDiskusi(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.diskusi,
    });

    List<Diskusi>? diskusi;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        diskusi: List<Diskusi>.from(json["Diskusi"].map((x) => Diskusi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Diskusi": List<dynamic>.from(diskusi!.map((x) => x.toJson())),
    };
}

class Diskusi {
    Diskusi({
        this.id,
        this.judul,
        this.deskripsi,
    });

    int? id;
    String? judul;
    String? deskripsi;

    factory Diskusi.fromJson(Map<String, dynamic> json) => Diskusi(
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
