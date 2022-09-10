// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/shared/shared.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';

import '../../api/api.dart';
import '../../rest/rest_Member.dart';

class ModalUpdateDataMember extends StatefulWidget {
  int idUser;
  ModalUpdateDataMember({Key? key, required this.idUser}) : super(key: key);

  @override
  State<ModalUpdateDataMember> createState() => _ModalUpdateDataMemberState();
}

class _ModalUpdateDataMemberState extends State<ModalUpdateDataMember> {
  TextEditingController? nama = TextEditingController();
  TextEditingController? username = TextEditingController();
  TextEditingController? password = TextEditingController();
  bool isLoading = false;

  Future<RestMember?> modalupdateDataMember() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions<Object?> options = MutationOptions(
          document: gql(QueryDataBase.upadateDataMemberById),
          variables: {
            'id': widget.idUser,
            'nama': nama!.text,
            'username': username!.text,
            'password': password!.text
          },);
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      if (result.data?.isNotEmpty == true) {
        setState(() {
          isLoading = false;
          Navigator.pop(context);
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Gagal Update Data"),
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
            height: MediaQuery.of(context).size.height / 1.5,
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
                          //Text("${widget.idUser}"),
                          const SizedBox(height: 35),
                          Text("Update Data Member", style: tb2),
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mainColor),
                            ),
                            child: CupertinoTextFormFieldRow(
                              placeholder: 'Nama',
                              controller: nama,
                              maxLines: 1,
                              padding: const EdgeInsets.all(18),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Isi Kolom Nama';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mainColor)
                            ),
                            child: CupertinoTextFormFieldRow(
                              placeholder: 'Username',
                              controller: username,
                              maxLines: 1,
                              padding: const EdgeInsets.all(18),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Isi Kolom Username';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mainColor)
                            ),
                            child: CupertinoTextFormFieldRow(
                              placeholder: 'Password',
                              controller: password,
                              maxLines: 1,
                              padding: const EdgeInsets.all(18),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Isi Kolom Password';
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
                                  child: const Text("Simpan"),
                                  onPressed: () async {
                                    if (nama!.text.isEmpty &&
                                        username!.text.isEmpty &&
                                        password!.text.isEmpty) {
                                      return null;
                                    } else {
                                      await modalupdateDataMember();
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
