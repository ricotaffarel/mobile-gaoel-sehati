// To parse this JSON data, do
//
//     final restPost = restPostFromJson(jsonString);

import 'dart:convert';

RestPost restPostFromJson(String str) => RestPost.fromJson(json.decode(str));

String restPostToJson(RestPost data) => json.encode(data.toJson());

class RestPost {
    RestPost({
        this.data,
    });

    Data? data;

    factory RestPost.fromJson(Map<String, dynamic> json) => RestPost(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.post,
    });

    List<Post>? post;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        post: List<Post>.from(json["Post"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Post": List<dynamic>.from(post!.map((x) => x.toJson())),
    };
}

class Post {
    Post({
        this.id,
        this.judul,
        this.deskripsi,
        this.photo,
    });

    int? id;
    String? judul;
    String? deskripsi;
    String? photo;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "deskripsi": deskripsi,
        "photo": photo,
    };
}
