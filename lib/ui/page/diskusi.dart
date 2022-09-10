// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/ui/page/chat.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/api.dart';
import '../../rest/rest_Diskusi.dart';
import '../../shared/shared.dart';

class TampilDiskusi extends StatefulWidget {
  TampilDiskusi({Key? key}) : super(key: key);

  @override
  State<TampilDiskusi> createState() => _TampilDiskusiState();
}

class _TampilDiskusiState extends State<TampilDiskusi> {
  List<Diskusi> dataDiskusi = [];
  bool isLoading = false;

  Future<RestDiskusi?> getDataDiskusi() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
        document: gql(QueryDataBase.getDataDiskusi),
      );
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Diskusi>? data = Data.fromJson(result.data!).diskusi;
      setState(() {
        isLoading = false;
        dataDiskusi = data ?? [];
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
    getDataDiskusi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Center(child: Text("Diskusi", style: tw1)),
            ),
            backgroundColor: w1,
            body: isLoading
                ? Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                        color: Colors.red, strokeWidth: 5),
                  )
                : SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: Column(
                      children: List.generate(
                        dataDiskusi.length,
                        (index) => Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15.0,
                                        left: 15,
                                        right: 15,
                                      ),
                                      child:
                                          Text(dataDiskusi[index].judul ?? ""),
                                    ),
                                    Center(
                                      child: CupertinoButton(
                                          child: const Text(
                                            "+ Lihat Diskusi",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Chating(
                                                          namaDiskusi:
                                                              dataDiskusi[index]
                                                                      .judul ??
                                                                  "",
                                                                  idDiskusi: dataDiskusi[index].id ?? 0,
                                                        )));
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ))));
  }
}
