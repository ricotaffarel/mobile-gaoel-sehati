import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/ui/page/Login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/api.dart';
import '../../api/sesionManajer.dart';
import '../../rest/rest_Member.dart';
import '../../shared/shared.dart';
import '../widget/modalTentang.dart';
import '../widget/modalUpdateDataMember.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int? id;
  bool isLoading = false;
  List<Member> dataMember = [];

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
        backgroundColor: w2,
        body: isLoading
            ? Container(
                alignment: Alignment.center,
                child: const Center(
                  child: CircularProgressIndicator(
                      color: Colors.red, strokeWidth: 5),
                ),
              )
            : ListView.builder(
                itemCount: dataMember.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: white,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 55,
                            ),
                            CircleAvatar(
                              radius: 55,
                              child: Icon(
                                Icons.person,
                                size: 65,
                                color: white,
                              ),
                              backgroundColor: w2,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(dataMember[index].nama ?? "", style: tb3),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(dataMember[index].username ?? "", style: tb3),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('${dataMember[index].createdAt}', style: tb3),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) =>
                                  ModalUpdateDataMember(idUser: id!));
                        },
                        child: Text(
                          "Edit Profile",
                          style: tw3,
                        ),
                        height: 50,
                        color: mainColor,
                        textColor: white,
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => const ModalTentang());
                        },
                        child: Text(
                          "Tentang",
                          style: tw3,
                        ),
                        height: 50,
                        color: mainColor,
                        textColor: white,
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await session.clearSessions().then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Login()),
                                (route) => false);
                          });
                        },
                        child: Text(
                          "Logout",
                          style: tw3,
                        ),
                        height: 50,
                        color: mainColor,
                        textColor: white,
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    ],
                  );
                }),
      ),
    );
  }
}
