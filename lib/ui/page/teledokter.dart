import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/api.dart';
import '../../rest/rest_Teledokter.dart';
import '../../shared/shared.dart';
import '../widget/widgets.dart';

class ListTeledokter extends StatefulWidget {
  ListTeledokter({Key? key}) : super(key: key);

  @override
  State<ListTeledokter> createState() => _TeledokterState();
}

class _TeledokterState extends State<ListTeledokter> {
  List<Teledokter> dataTeledokter = [];
  bool isLoading = false;

  Future<RestTeledokter?> getDataTeledokter() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
        document: gql(QueryDataBase.getDataTeledokter),
      );
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Teledokter>? data = Dataa.fromJson(result.data!).teledokter;
      setState(() {
        isLoading = false;
        dataTeledokter = data ?? [];
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
    getDataTeledokter();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: w1,
            body: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            const EdgeInsets.only(top: 34, left: 20, right: 5),
                        child: Text(
                          'Jika ada kendala segera konsultasikan kesetahanmu secara online',
                          textAlign: TextAlign.left,
                          style: tUngu,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 10),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset('assets/animasikesehatan.png',
                            width: MediaQuery.of(context).size.width / 2.2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: warning,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Container(
                          width: 30,
                          margin: const EdgeInsets.only(right: 15),
                          child: Image.asset(
                            'assets/warning.png',
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 90,
                        child: Text(
                          'Pemeriksaan kesehatan mandiri dan telekonsultasi dokter akan difasilitasi oleh aplikasi dan pihak ketiga. Seluruh kontennya merupakan tanggung jawab pihak ketiga tersebut',
                          style: twarning,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                      child: isLoading
            ? Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Center(
                  child: CircularProgressIndicator(
                      color: Colors.red, strokeWidth: 5),
                ),
              )
            : Column(
                    children: List.generate(
                      dataTeledokter.length,
                      (index) => Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: white,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewTeledokter(
                                                id: dataTeledokter[index].id ??
                                                    0,
                                                nama: dataTeledokter[index]
                                                        .nama ??
                                                    "",
                                                link: dataTeledokter[index]
                                                        .link ??
                                                    "",
                                              )));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 1.7,
                                        padding: const EdgeInsets.only(
                                          top: 25.0,
                                          left: 15,
                                          right: 15,
                                          bottom: 25,
                                        ),
                                        child: Image.network(
                                          dataTeledokter[index].photo ?? "", 
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ))));
  }
}
