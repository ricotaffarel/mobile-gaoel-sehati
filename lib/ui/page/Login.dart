// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gaoel_sehat/ui/page/pages.dart';
import 'package:gaoel_sehat/ui/page/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/api.dart';
import '../../api/sesionManajer.dart';
import '../../rest/rest_Member.dart';
import '../../shared/shared.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLogin = false;

  Future<RestMember?> loginMember() async {
    try {
      setState(() {
        isLogin = true;
      });
      final MutationOptions options = MutationOptions(
          document: gql(QueryDataBase.loginMember),
          variables: {'username': username.text, 'password': password.text});

      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Member>? member = Dataa.fromJson(result.data!).member;
      if (member?[0].username == username.text &&
          member?[0].password == password.text) {
        setState(() {
          session.saveSessions(member?[0].id);
          isLogin = false;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainPage()),
              (route) => false);
        });
      } else {
        setState(() {
          isLogin = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Username atau Password yang anda masukan salah"),
            backgroundColor: Colors.red,
          ));
        });
      }
    } catch (e) {
      isLogin = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username atau Password yang anda masukan salah"),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset("assets/Vector3.png"),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Image.asset("assets/Logo.png"),
                  ),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width - 150,
                    decoration: BoxDecoration(
                        color: w2, borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Silahkan Log-In",
                        style: tm4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width - 65,
                    padding: const EdgeInsets.only(top: 9, left: 20),
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
                        hintText: "Username/email",
                        hintStyle: tb1,
                        prefixIcon: Icon(Icons.email, color: mainColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width - 65,
                    padding: const EdgeInsets.only(top: 9, left: 20.0),
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
                        prefixIcon: Icon(Icons.lock, color: mainColor),
                      ),
                    ),
                  ),
                  isLogin
                      ?  Container(
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
                              top: 30, bottom: 20, left: 67, right: 67),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await loginMember();
                              }
                            },
                            style: TextButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: mainColor,
                            ),
                            child: Text(
                              'Log-In',
                              style: tw3,
                            ),
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.75,
                      child: Row(
                        children: [
                          Text("Silahkan Register",
                              style: GoogleFonts.poppins(
                                color: mainColor,
                                fontSize: 14,
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Register()),
                                  (route) => false);
                            },
                            child: Text("Disini",
                                style: GoogleFonts.poppins(
                                    color: mainColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset("assets/Vector4.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
