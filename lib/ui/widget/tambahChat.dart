// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/shared/shared.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/api.dart';
import '../../rest/rest_Chat.dart';

class TambahChat extends StatefulWidget {
  int idDiskusi;
  int idUser;
  Function getdata;
  TambahChat({Key? key, required this.idDiskusi, required this.idUser, required this.getdata}) : super(key: key);

  @override
  State<TambahChat> createState() => _TambahChatState();
}

class _TambahChatState extends State<TambahChat> {
  TextEditingController? chat = TextEditingController();
  bool isLoading = false;

  Future<RestChat?> tambahChat() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions<Object?> options =
          MutationOptions(document: gql(QueryDataBase.insertChat), variables: {
        'id_diskusi': widget.idDiskusi,
        'id_user': widget.idUser,
        'messege': chat?.text,
      });
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      if (result.data?.isNotEmpty == true) {
        setState(() {
          isLoading = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Berhasil Mengirim Chat"),
            backgroundColor: Colors.red,
          ));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Gagal Mengirim Chat"),
            backgroundColor: Colors.red,
          ));
        });
      }
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
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        //backgroundColor: Colors.transparent,
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
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: () {
                        Form.of(primaryFocus!.context!)?.save();
                      },
                      child: Column(
                        children: [
                          // Text("${widget.idUser}"),
                          // Text("${widget.idDiskusi}"),
                          const SizedBox(height: 20),
                          Text("Silahkan Isi Chat", style: tb2),
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mainColor)
                            ),
                            child: CupertinoTextFormFieldRow(
                              placeholder: 'Isi Chat',
                              controller: chat,
                              maxLines: 3,
                              padding: const EdgeInsets.all(18),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Isi Kolom Chat';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          isLoading
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.red, strokeWidth: 5),
                                  ),
                                )
                              : CupertinoButton(
                                  child: const Text("+ Tambah"),
                                  onPressed: () async {
                                    if (chat!.text.isEmpty) {
                                      return null;
                                    } else {
                                      await tambahChat();
                                      await widget.getdata();
                                    }
                                  })
                        ],
                      ),
                    )
                  ]),
                )
              ],
            )));
  }
}