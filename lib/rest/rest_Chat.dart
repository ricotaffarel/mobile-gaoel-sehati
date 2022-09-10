// To parse this JSON data, do
//
//     final restChat = restChatFromJson(jsonString);

import 'dart:convert';

RestChat restChatFromJson(String str) => RestChat.fromJson(json.decode(str));

String restChatToJson(RestChat data) => json.encode(data.toJson());

class RestChat {
    RestChat({
        this.data,
    });

    Data? data;

    factory RestChat.fromJson(Map<String, dynamic> json) => RestChat(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.chat,
    });

    List<Chat>? chat;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        chat: List<Chat>.from(json["Chat"].map((x) => Chat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Chat": List<dynamic>.from(chat!.map((x) => x.toJson())),
    };
}

class Chat {
    Chat({
        this.id,
        this.idDiskusi,
        this.idUser,
        this.messege,
        this.createdAt,
    });

    int? id;
    int? idDiskusi;
    int? idUser;
    String? messege;
    DateTime? createdAt;

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        idDiskusi: json["id_diskusi"],
        idUser: json["id_user"],
        messege: json["messege"],
        createdAt:  json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_diskusi": idDiskusi,
        "id_user": idUser,
        "messege": messege,
        "created_at": createdAt!.toIso8601String(),
    };
}
