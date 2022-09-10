// ignore_for_file: must_be_immutable, file_names

part of 'widgets.dart';

class TambahKomentar extends StatefulWidget {
  int idPost;
  int idUser;
  String namaUser;
  Function getdata;
  TambahKomentar(
      {Key? key,
      required this.idPost,
      required this.idUser,
      required this.namaUser,
      required this.getdata,
      })
      : super(key: key);

  @override
  State<TambahKomentar> createState() => _TambahKomentarState();
}

class _TambahKomentarState extends State<TambahKomentar> {
  TextEditingController? komentar = TextEditingController();
  bool isLoading = false;

  Future<RestKomentar?> tambahKomentar() async {
    try {
      setState(() {
        isLoading = true;
      });
      final MutationOptions<Object?> options =
          MutationOptions(document: gql(QueryDataBase.insertKomen), variables: {
        'id_post': widget.idPost,
        'id_user': widget.idUser,
        'komen': komentar!.text,
      });
      final QueryResult result =
          await QueryDataBase.client.value.mutate(options);
      if (result.data?.isNotEmpty == true) {
        setState(() {
          isLoading = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Berhasil Mengirim Komentar"),
            backgroundColor: Colors.red,
          ));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Gagal Mengirim Komentar"),
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
                          const SizedBox(height: 20),
                          Text("Silahkan Isi Komentar", style: tb2),
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mainColor)
                            ),
                            child: CupertinoTextFormFieldRow(
                              placeholder: 'Isi Komentar',
                              controller: komentar,
                              maxLines: 3,
                              padding: const EdgeInsets.all(18),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Isi Kolom Komentar';
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
                                    if (komentar!.text.isEmpty) {
                                      return null;
                                    } else {
                                      await tambahKomentar();
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
