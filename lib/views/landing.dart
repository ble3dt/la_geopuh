import 'package:flutter/material.dart';
import 'package:la_geopuh/data/auth/user.dart';
import 'package:la_geopuh/views/pages/auth_page.dart';
import 'package:la_geopuh/views/pages/home_page.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? userModel = Provider.of<UserModel?>(context);
    final bool isAuthed = userModel != null;

    return isAuthed ? const HomePage() : const AuthPage();
  }
}
