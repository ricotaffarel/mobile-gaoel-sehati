// To parse this JSON data, do
//
//     final restMember = restMemberFromJson(jsonString);

import 'dart:convert';

RestMember restMemberFromJson(String str) => RestMember.fromJson(json.decode(str));

String restMemberToJson(RestMember data) => json.encode(data.toJson());

class RestMember {
    RestMember({
        this.dataa,
    });

    Dataa? dataa;

    factory RestMember.fromJson(Map<String, dynamic> json) => RestMember(
        dataa: Dataa.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": dataa!.toJson(),
    };
}

class Dataa {
    Dataa({
        this.member,
    });

    List<Member>? member;

    factory Dataa.fromJson(Map<String, dynamic> json) => Dataa(
        member: List<Member>.from(json["member"].map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "member": List<dynamic>.from(member!.map((x) => x.toJson())),
    };
}

class Member {
    Member({
        this.id,
        this.nama,
        this.username,
        this.password,
        this.createdAt,
    });

    int? id;
    String? nama;
    String? username;
    String? password;
    DateTime? createdAt;

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        nama: json["nama"],
        username: json["username"],
        password: json["password"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "username": username,
        "password": password,
        "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    };
}
