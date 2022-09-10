// ignore_for_file: file_names

part of 'pages.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 32, top: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Sehat",
                              style: tm1,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 32,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Itu Nomor 1",
                              style: tm1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset("assets/Vector1.png"),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 55),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/animasi.png",
                      width: MediaQuery.of(context).size.width - 70,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Text(
                        "Aplikasi Layanan Diskusi & Edukasi HIV/AIDS",
                        style: tm2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Text(
                          "Pada aplikasi ini anda dapat mencari informasi, edukasi, forum discuss, serta obat-obatan seputar HIV/AIDS. Anda pun dapat melakukan konsultasi bersama dokter.",
                          style: tm3,
                          textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(
                    top: 14, bottom: 20, left: 67, right: 67),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Login()));
                  },
                  style: TextButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: mainColor,
                  ),
                  child: Text(
                    'Mulai',
                    style: tw3,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Image.asset("assets/Vector2.png"),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
