import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/api/sesionManajer.dart';
import 'package:gaoel_sehat/ui/page/chat.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/api.dart';
import '../../rest/rest_Chat.dart';
import '../../shared/shared.dart';
import '../widget/tambahChat.dart';

class Chating extends StatefulWidget {
  String namaDiskusi;
  int idDiskusi;
  Chating({Key? key, required this.namaDiskusi, required this.idDiskusi})
      : super(key: key);

  @override
  State<Chating> createState() => _ChatingState();
}

class _ChatingState extends State<Chating> {
  List<Chat> dataChat = [];
  bool isLoading = false;
  int? id;

  Future<RestChat?> getDataChat() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
          document: gql(QueryDataBase.getDataChat),
          variables: {'id_diskusi': widget.idDiskusi});
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Chat>? data = Data.fromJson(result.data!).chat;
      setState(() {
        isLoading = false;
        dataChat = data ?? [];
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
    getDataChat();
    setState(() {
      id = session.idMember;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Silahkan Diskusi',
              style: tw5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: white,
            )),
        actions: [
          CupertinoButton(
            child: Text(
              "+ chat",
              style: tw3,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) => TambahChat(
                        idDiskusi: widget.idDiskusi,
                        idUser: id!,
                        getdata: getDataChat,
                      ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Column(
                children: List.generate(
                    dataChat.length,
                    (index) => isLoading
                        ? Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.red, strokeWidth: 5),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: (id == dataChat[index].idUser)
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.70),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: (id == dataChat[index].idUser)
                                          ? mainColor
                                          : white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ]),
                                  child: Text(dataChat[index].messege ?? "",
                                      style: (id == dataChat[index].idUser)
                                          ? const TextStyle(
                                              fontSize: 12, color: Colors.white)
                                          : const TextStyle(
                                              color: Colors.black)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    (id == dataChat[index].idUser)
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 5,
                                              spreadRadius: 2),
                                        ]),
                                    child: const CircleAvatar(
                                      radius: 15,
                                      child: Icon(Icons.person, size: 25),
                                    ),
                                  ),
                                  Text(
                                      "ID MEMBER-"
                                      "${dataChat[index].idUser}",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black45))
                                ],
                              )
                            ],
                          ))),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
