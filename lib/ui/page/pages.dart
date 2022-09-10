import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaoel_sehat/api/api.dart';
import 'package:gaoel_sehat/api/sesionManajer.dart';
import 'package:gaoel_sehat/shared/shared.dart';
import 'package:gaoel_sehat/ui/page/Login.dart';
import 'package:gaoel_sehat/ui/page/diskusi.dart';
import 'package:gaoel_sehat/ui/page/home.dart';
import 'package:gaoel_sehat/ui/page/profile.dart';
import 'package:gaoel_sehat/ui/page/teledokter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../rest/rest_Edukasi.dart';
import '../widget/widgets.dart';

part 'laucher.dart';
part 'getStarted.dart';
part 'main_page.dart';
part 'edukasi.dart';