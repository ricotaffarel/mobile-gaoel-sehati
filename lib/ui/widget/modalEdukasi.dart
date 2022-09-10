part of 'widgets.dart';

class ModalEdukasi extends StatelessWidget {
  String judul;
  String deskripsi;
  ModalEdukasi({Key? key, required this.judul, required this.deskripsi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(judul, style: tb2),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(deskripsi, style: CupertinoTheme.of(context).textTheme.textStyle, textAlign: TextAlign.justify),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  ]),
                )
              ],
            )));
  }
}
