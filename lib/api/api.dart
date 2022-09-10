import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QueryDataBase {
  static String loginMember = """
  query loginMember(\$username: String, \$password: String) {
  member(where: {username: {_eq: \$username}, password: {_eq: \$password}}) {
    id
    nama
    username
    password
  }
}
  """;

  static String registerMember =
      '''mutation addDataMember(\$nama: String, \$username: String, \$password: String, \$created_at: date) {
  action: insert_member(objects: {nama: \$nama, username: \$username, password: \$password, created_at: \$created_at}) {
    returning {
      id
      nama
      username
      password
      created_at
    }
  }
}
''';

  static String getDataMemberById = """
    query getDataMember (\$id: Int){
      member (where: {id: {_eq: \$id}}){
      id
      nama
      username
      password
      created_at
  }
}
""";

  static String upadateDataMemberById = """
    mutation updateMemberById(\$id: Int, \$nama: String, \$username: String, \$password: String) {
      update_member(where: {id: {_eq: \$id}}, _set: {nama: \$nama, username: \$username, password: \$password}) {
    returning {
      id
      nama
      username
      password
    }
  }
}

""";

  static String getDataPost = """
    query getDataPost {
      Post {
        id
        judul
        deskripsi
        photo
    }
}
""";

  static String getDataPostByIId = """
    query getDataKomenById (\$id: Int){
      Komentar (where: {id_post: {_eq: \$id}}){
        id
        id_post
        id_user
        komen
    }
}
""";

  static String deleteDataKomenByIIdUser = """
    mutation delete_komentar(\$id_user: Int, \$id: Int) {
      delete_Komentar(where: {id_user: {_eq: \$id_user}, id: {_eq: \$id}}) {
        returning{
          id
          id_post
          id_user
          komen
        }
  }
}
""";

  static String getDataKomenByIdPost = """
    query getDataKomen (\$id_post: Int){
      Komentar (where: {id_post: {_eq: \$id_post}}){
        id
        id_post
        id_user
      	komen
    }
  }
""";

  static String insertKomen = """
     mutation addKomentar(\$id_post: Int, \$id_user: Int, \$komen: String) {
  action: insert_Komentar(objects: {id_post: \$id_post, id_user: \$id_user, komen: \$komen}) {
    returning {
      id
      id_post
      id_user
      komen
    }
  }
}

""";

  static String getDataEdukasi = """
    query getDataEdukasi {
      Edukasi{
        id
        judul
        deskripsi
  }
}
""";

  static String getDataTeledokter = """
    query getDataTeledokter {
      Teledokter{
        id
        nama
        photo
        link
  }
}
""";

  static String getDataAbout = """
    query getDataAbout {
      About{
        id
        judul
        deskripsi
  }
}
""";

  static String getDataDiskusi = """
    query getDataDiskusi {
      Diskusi{
        id
        judul
        deskripsi
  }
}
""";

  static String getDataChat = """
    query getDataChat (\$id_diskusi: Int){
      Chat (where: {id_diskusi: {_eq: \$id_diskusi}}){
        id
        id_diskusi
        id_user
      	messege
    }
  }
""";

  static String insertChat = """
     mutation addChat(\$id_diskusi: Int, \$id_user: Int, \$messege: String) {
  action: insert_Chat(objects: {id_diskusi: \$id_diskusi, id_user: \$id_user, messege: \$messege}) {
    returning {
      id
      id_diskusi
      id_user
      messege
    }
  }
}
""";

  static HttpLink httpLink = HttpLink(
      "https://sought-coral-43.hasura.app/v1/graphql",
      defaultHeaders: {
        "content-type": "application/json",
        "x-hasura-admin-secret":
            "mR18dE2TUIfGNuN4EyIBEW4btcGPRWjGyqNEtswd0v2pQ20UqND6xfylsCLenAdi"
      });

  static Link link = httpLink;
  static ValueNotifier<GraphQLClient> client =
      ValueNotifier(GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore())));
}
