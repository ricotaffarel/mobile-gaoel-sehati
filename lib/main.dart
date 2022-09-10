import 'package:flutter/material.dart';
import 'package:gaoel_sehat/api/api.dart';
import 'package:gaoel_sehat/ui/page/pages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  var app = GraphQLProvider(client: QueryDataBase.client, child: const MyApp());
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LauncherPage(),
    );
  }
}
