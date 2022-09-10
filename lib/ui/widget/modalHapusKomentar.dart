// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/shared/shared.dart';

class ModalHapusKomentar extends StatefulWidget {
  Function delete;
  Function getdata;
  ModalHapusKomentar({Key? key, required this.delete, required this.getdata})
      : super(key: key);

  @override
  State<ModalHapusKomentar> createState() => _ModalHapusKomentarState();
}

class _ModalHapusKomentarState extends State<ModalHapusKomentar> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: Container(
            height: MediaQuery.of(context).size.height / 3,
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
                    Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text(
                            "Yakin Ingin Menghapus Komentar ?",
                            style: tm4,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoading
                                ? Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.red, strokeWidth: 5),
                                    ),
                                  )
                                : CupertinoButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await widget.delete();
                                        await widget.getdata();
                                    },
                                    color: mainColor,
                                    child: Text("Ya", style: tw3),
                                  ),
                            const SizedBox(
                              width: 40,
                            ),
                            CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: mainColor,
                              child: Text("Tidak", style: tw3),
                            ),
                          ],
                        )
                      ],
                    )
                  ]),
                )
              ],
            )));
  }
}
