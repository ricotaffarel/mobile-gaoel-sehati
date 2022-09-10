// ignore_for_file: prefer_const_constructors_in_immutables

part of 'pages.dart';

class LisEdukasi extends StatefulWidget {
  LisEdukasi({Key? key}) : super(key: key);

  @override
  State<LisEdukasi> createState() => _EdukasiState();
}

class _EdukasiState extends State<LisEdukasi> {
  List<Edukasi> dataEdukasi = [];
  bool isLoading = false;

  Future<RestEdukasi?> getDataEdukasi() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions options = MutationOptions(
        document: gql(QueryDataBase.getDataEdukasi),
      );
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      List<Edukasi>? data = Data.fromJson(result.data!).edukasi;
      setState(() {
        isLoading = false;
        dataEdukasi = data ?? [];
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
    getDataEdukasi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Center(child: Text("Edukasi", style: tw1)),
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
                  dataEdukasi.length,
                  (index) => Column(
                    children: [
                      const SizedBox(height: 40,),
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
                                child: Text(dataEdukasi[index].judul ?? ""),
                              ),
                              Center(
                                child: CupertinoButton(
                                    child: const Text(
                                      "+ Lihat Edukasi",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => ModalEdukasi(
                                              judul: dataEdukasi[index].judul ?? "",
                                              deskripsi:
                                                  dataEdukasi[index].deskripsi ??
                                                      ""));
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
