import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaoel_sehat/ui/page/Login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../api/api.dart';
import '../../shared/shared.dart';
import '../../rest/rest_Member.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegister = false;
  String? createdAt = DateFormat("yyyy-MM-dd").format(DateTime.now());

  Future<RestMember?> registerMember() async {
    try {
      setState(() {
        isRegister = true;
      });
      final MutationOptions<Object?> options = MutationOptions(
          document: gql(QueryDataBase.registerMember),
          variables: {
            'nama': nama.text,
            'username': username.text,
            'password': password.text,
            'created_at': createdAt.toString()
          });
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      log("{$nama}");
      log("{$username}");
      log("{$password}");
      log(createdAt!);
      if (result.data?.isNotEmpty == true) {
        setState(() {
          isRegister = false;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Login()),
              (route) => false);
        });
      } else {
        setState(() {
          isRegister = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Gagal Daftar"),
            backgroundColor: Colors.red,
          ));
        });
      }
    } catch (e) {
      isRegister = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: _formKey,
        child: ListView(children: [
          Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 15),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                              (route) => false);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: Image.asset("assets/Vector1.png",
                          width: MediaQuery.of(context).size.width / 2))
                ],
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 13),
                width: MediaQuery.of(context).size.width - 150,
                decoration: BoxDecoration(
                    color: w2, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Register",
                    style: tm4,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width - 65,
                padding: const EdgeInsets.only(top: 7, left: 30.0),
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: mainColor)),
                child: TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                  },
                  controller: nama,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nama lengkap",
                    hintStyle: tb1,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width - 65,
                padding: const EdgeInsets.only(top: 7, left: 30.0),
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: mainColor)),
                child: TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    hintStyle: tb1,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width - 65,
                padding: const EdgeInsets.only(top: 7, left: 30.0),
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: mainColor)),
                child: TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                  },
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: tb1,
                  ),
                ),
              ),
              isRegister
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: Colors.red, strokeWidth: 5),
                      ),
                    )
                  : Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 50, bottom: 70, left: 67, right: 67),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await registerMember();
                          }
                        },
                        style: TextButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: mainColor,
                        ),
                        child: Text(
                          'Register',
                          style: tw4,
                        ),
                      ),
                    ),
            ],
          ),
        ]),
      )),
    );
  }
}
