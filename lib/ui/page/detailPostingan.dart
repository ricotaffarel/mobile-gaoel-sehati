import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/rest/rest_Komentar.dart';
import 'package:gaoel_sehat/ui/widget/modalHapusKomentar.dart';
import 'package:gaoel_sehat/ui/widget/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../api/api.dart';
import '../../shared/shared.dart';

class DetailPostingan extends StatefulWidget {
  String judul;
  String photo;
  String deskripsi;
  int idPost;
  int idUser;
  String namaUser;
  DetailPostingan(
      {Key? key,
      required this.judul,
      required this.photo,
      required this.deskripsi,
      required this.idPost,
      required this.idUser,
      required this.namaUser})
      : super(key: key);

  @override
  State<DetailPostingan> createState() => _DetailPostinganState();
}

class _DetailPostinganState extends State<DetailPostingan> {
  bool isLoading = false;
  List<Komentar> dataKomen = [];
  int? idKomentar;
  int? idUser;

  Future<RestKomentar?> getKomentar() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
          document: gql(QueryDataBase.getDataKomenByIdPost),
          variables: {'id_post': widget.idPost});
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Komentar>? data = Data.fromJson(result.data!).komentar;
      setState(() {
        isLoading = false;
        dataKomen = data ?? [];
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

  Future<RestKomentar?> deleteKomentar() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
          document: gql(QueryDataBase.deleteDataKomenByIIdUser),
          variables: {
            'id_user': idUser!,
            'id': idKomentar!,
          });
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil Menghapus Komentar"),
        backgroundColor: Colors.red,
      ));
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
    getKomentar();
    idUser = widget.idUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  alignment: Alignment.topRight,
                  child: Image.asset("assets/Vector5.png",
                      width: MediaQuery.of(context).size.width / 1)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: white,
                    )),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, top: 15),
                  child: CupertinoButton(
                    child: Text(
                      "Tambah\nKomentar",
                      style: tb4,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => TambahKomentar(
                                idPost: widget.idPost,
                                namaUser: widget.namaUser,
                                idUser: widget.idUser,
                                getdata: getKomentar,
                              ));
                    },
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 80.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(widget.photo)),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ),
                      child: Text(
                        widget.judul,
                        style: tb2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        widget.deskripsi,
                        style: tb1,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text("Komentar", style: tb2),
                    const SizedBox(height: 15),
                    isLoading
                        ? Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.red, strokeWidth: 5),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  dataKomen.length,
                                  (index) => Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all()),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              const Icon(
                                                Icons.person,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        "ID Member " +
                                                            "${dataKomen[index].idUser}",
                                                        style: TextStyle(
                                                            color: white),
                                                      ),
                                                    ),
                                                  ]),
                                            ]),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 10,
                                                right: 8.0,
                                              ),
                                              child: Text(
                                                "${dataKomen[index].komen}",
                                                style: TextStyle(color: white),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            if (dataKomen[index].idUser ==
                                                idUser)
                                              Center(
                                                child: IconButton(
                                                    onPressed: () async {
                                                      idKomentar =
                                                          dataKomen[index].id;
                                                      showCupertinoModalPopup(
                                                          context: context,
                                                          builder: (context) =>
                                                              ModalHapusKomentar(
                                                                delete:
                                                                    deleteKomentar,
                                                                getdata:
                                                                    getKomentar,
                                                              ));
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            const SizedBox(height: 20)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 30)
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    )));
  }
}
