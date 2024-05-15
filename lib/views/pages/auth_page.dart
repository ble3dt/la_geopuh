import 'package:flutter/material.dart';
import 'package:la_geopuh/assets/colors.dart';
import 'package:la_geopuh/assets/themes.dart';
import 'package:la_geopuh/data/auth/user_service.dart';
import 'package:toast/toast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

TextEditingController loginController = TextEditingController();
TextEditingController passwordController = TextEditingController();

AuthService authService = AuthService();

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: Image.asset("lib/assets/pics/proficon.png"))),
                  TextField(
                    controller: loginController,
                    cursorColor: regular.withOpacity(0.6),
                    style: labelStyle,
                    decoration: InputDecoration(
                      label: const Text("Логин"),
                      labelStyle: transparentLabelStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: accent_1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: accent_2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: regular),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    cursorColor: regular.withOpacity(0.6),
                    style: labelStyle,
                    decoration: InputDecoration(
                      label: const Text("Пароль"),
                      labelStyle: transparentLabelStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: accent_1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: accent_2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: regular),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (loginController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            Toast.show("Заполните все поля");
                          } else {
                            var user = await authService.signIn(
                                loginController.text, passwordController.text);
                            if (user == null) {
                              Toast.show("Пользователя не существует");
                            } else {
                              Navigator.popAndPushNamed(context, "/");
                              Toast.show("Вы успешно вошли");
                            }
                          }
                        },
                        style: accentButton,
                        child: Text(
                          "Войти",
                          style: buttonTextStyle,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/reg");
                        },
                        child: Text(
                          "Нет аккаунта?",
                          style: transparentLabelStyle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
