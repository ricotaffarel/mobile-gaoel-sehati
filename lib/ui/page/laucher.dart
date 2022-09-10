part of 'pages.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  // startLaunching() async {
  //   var duration = const Duration(seconds: 7);
  //   return Timer(duration, () {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const GetStarted()));
  //   });
  // }

  Future cekSession() async {
    return Future.delayed(const Duration(seconds: 5), () {
      session.getSessions().then((value) {
        if (value != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainPage()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const GetStarted()),
              (route) => false);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    cekSession();
  } 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/Logo.png",
              height: 160,
              width: size.width,
            ),
          ),
        ],
      ),
    );
  }
}
