// part of 'pages.dart';

// class ListPostingan extends StatefulWidget {
//   ListPostingan({Key? key}) : super(key: key);

//   @override
//   State<ListPostingan> createState() => _ListPostinganState();
// }

// class _ListPostinganState extends State<ListPostingan> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemBuilder: (BuildContext context, index) {
//           Postingan postingan = postinganList[index];
//           return InkWell(
//             onTap: () {
//               Get.to(DetailPostingan());
//             },
//             child: Container(
//               width: 250,
//               padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
//               child: Column(
//                 children: [
//                   Image.network(postingan.photo,),
//                   const SizedBox(height: 20,),
//                   Text(postingan.judul, style: tb1,)
//                 ],
//               ),
//             )
//           );
//         },
//         itemCount: postinganList.length,
//         ),
//     );
//   }
// }

// ListView.builder(
//         itemBuilder: (BuildContext context, index) {
//           Postingan postingan = postinganList[index];
//           return InkWell(
//             onTap: () {
//               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DetailPostingan()), (route) => false);
//             },
//             child: Container(
//               width: 250,
//               padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image(image: NetworkImage(postingan.photo)),
//                   const SizedBox(height: 20,),
//                   Text(postingan.judul, style: tb1, textAlign: TextAlign.left,)
//                 ],
//               ),
//             )
//           );
//         },
//         itemCount: postinganList.length,
//         ),