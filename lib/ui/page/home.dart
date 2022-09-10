import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/rest/rest_Member.dart';
import 'package:gaoel_sehat/ui/page/detailPostingan.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/api.dart';
import '../../api/sesionManajer.dart';
import '../../rest/rest_Post.dart';
import '../../shared/shared.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> dataPost = [];
  List<Member> dataMember = [];
  bool isLoading = false;
  int? id;

  Future<RestPost?> getDataPost() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
        document: gql(QueryDataBase.getDataPost),
      );
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Post>? post = Data.fromJson(result.data!).post;
      setState(() {
        isLoading = false;
        dataPost = post ?? [];
      });
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }

  Future<RestMember?> getMember() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
          document: gql(QueryDataBase.getDataMemberById),
          variables: {'id': id});
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Member>? data = Dataa.fromJson(result.data!).member;
      setState(() {
        isLoading = false;
        dataMember = data ?? [];
      });
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getDataPost();
    session.getSessions().then((value) {
      setState(() {
        id = session.idMember;
      });
      getMember();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: w4,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                ///Header
                SizedBox(
                  //height: 100,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Image.asset("assets/Vector5.png"),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: Icon(Icons.person, size: 35, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 29, left: 60),
                  child: Column(
                    children: [
                      for (int a = 0; a < dataMember.length; a++)
                        Text("Hai ${dataMember[a].nama}", style: tw2),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 26),
                  child: Text("Temukan", style: tw3),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 85, left: 26),
                  child: Text("Informasi Terbaikmu !", style: tw2),
                ),

                ///POSTINGAN
                isLoading
                    ? Container(
                        margin: const EdgeInsets.only(top: 250),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                            color: Colors.red, strokeWidth: 5),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 115),
                        child: Column(
                          children: List.generate(
                              dataPost.length,
                              (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPostingan(
                                                  idUser: dataMember[0].id ?? 0,
                                                  photo:
                                                      dataPost[index].photo ??
                                                          "",
                                                  deskripsi: dataPost[index]
                                                          .deskripsi ??
                                                      "",
                                                  judul:
                                                      dataPost[index].judul ??
                                                          "",
                                                  idPost:
                                                      dataPost[index].id ?? 0,
                                                  namaUser:
                                                      dataMember[0].nama ?? "",
                                                )));
                                  },
                                  child: Container(
                                    //color: white,
                                    padding: const EdgeInsets.only(
                                        left: 35, right: 35, top: 20),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                              dataPost[index].photo ?? ""),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          dataPost[index].judul ?? "",
                                          style: tb1,
                                        ),
                                      ],
                                    ),
                                  ))),
                        )),
              ]),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
