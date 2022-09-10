part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int _selectedIndex = 2;
  static final List<Widget> _widgetOptions = <Widget>[
    Center(
      child: TampilDiskusi(),
    ),
    Center(
      child: LisEdukasi(),
    ),
    const Center(
      child: Home(),
    ),
    Center(
      child: ListTeledokter(),
    ),
    const Center(
      child: Profile(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60,
        items: [
          Icon(
            Icons.chat,
            size: 27,
            color: mainColor,
          ),
          Icon(
            Icons.history_edu_sharp,
            size: 27,
            color: mainColor,
          ),
          Icon(
            Icons.home,
            size: 27,
            color: mainColor,
          ),
          Image.asset("assets/teledokter_normal.png",
              width: 23, color: mainColor),
          Icon(
            Icons.person,
            size: 27,
            color: mainColor,
          )
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: w4,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SafeArea(
              child: Container(
            color: w4,
          )),
          Center(child: _widgetOptions.elementAt(_selectedIndex)),
        ],
      ),
    );
  }
}
