// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:la_geopuh/data/firebase_firestore/profile_collection.dart';

import '../../assets/colors.dart';
import '../../assets/themes.dart';

import 'package:toast/toast.dart';

import '../../data/auth/user_service.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({super.key});

  @override
  State<RegistPage> createState() => _RegistPageState();
}

TextEditingController surnameController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController loginController = TextEditingController();
TextEditingController passwordController = TextEditingController();

AuthService authService = AuthService();

ProfileCollection profileCollection = ProfileCollection();

class _RegistPageState extends State<RegistPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: regular,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          child: Image.asset("lib/assets/pics/proficon.png"))),
                  TextField(
                    controller: surnameController,
                    cursorColor: regular.withOpacity(0.6),
                    style: labelStyle,
                    decoration: InputDecoration(
                      label: const Text("Фамилия"),
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
                    controller: nameController,
                    cursorColor: regular.withOpacity(0.6),
                    style: labelStyle,
                    decoration: InputDecoration(
                      label: const Text("Имя"),
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
                    controller: phoneController,
                    cursorColor: regular.withOpacity(0.6),
                    style: labelStyle,
                    decoration: InputDecoration(
                      label: const Text("Телефон"),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (surnameController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          loginController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        Toast.show("Заполните все поля");
                      } else if (passwordController.text.length <= 6) {
                        Toast.show("Пароль должен быть больше 6 символов");
                      } else {
                        var user = await authService.signUp(
                            loginController.text, passwordController.text);
                        if (user == null) {
                          Toast.show("Неверная почта");
                        } else {
                          profileCollection.addProfile(
                              user.id!,
                              surnameController.text,
                              nameController.text,
                              phoneController.text,
                              loginController.text,
                              passwordController.text,
                              "");
                          Toast.show("Аккаунт успешно создан");
                          Navigator.popAndPushNamed(context, "/");
                        }
                      }
                    },
                    style: accentButton,
                    child: Text(
                      "Создать аккаунт",
                      style: buttonTextStyle,
                    ),
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
