// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/shared/shared.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';

import '../../api/api.dart';
import '../../rest/rest_About.dart';

class ModalTentang extends StatefulWidget {
  const ModalTentang({Key? key}) : super(key: key);

  @override
  State<ModalTentang> createState() => _ModalTentangState();
}

class _ModalTentangState extends State<ModalTentang> {
  List<About> dataAbout = [];
  bool isLoading = false;

  Future<RestAbout?> getDataAbout() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
        document: gql(QueryDataBase.getDataAbout),
      );
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<About>? data = Data.fromJson(result.data!).about;
      setState(() {
        isLoading = false;
        dataAbout = data ?? [];
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
    getDataAbout();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: double.infinity,
            decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    isLoading
                        ? Container(
                            margin: const EdgeInsets.only(top: 55),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.red, strokeWidth: 5),
                            ),
                          )
                        : Column(
                        children: List.generate(
                            dataAbout.length,
                            (index) => Column(
                                  children: [
                                    const SizedBox(height: 40),
                                    Text(dataAbout[index].judul ?? "", style: tb2),
                                    const SizedBox(height: 30),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0),
                                      child: Text(dataAbout[index].deskripsi ?? "",
                                          style: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle,
                                          textAlign: TextAlign.justify),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                )))
                  ]),
                )
              ],
            )));
  }
}
