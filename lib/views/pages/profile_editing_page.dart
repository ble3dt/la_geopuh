import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:la_geopuh/data/firebase_firestore/profile_collection.dart';

import 'package:toast/toast.dart';

import '../../assets/colors.dart';
import '../../assets/themes.dart';
import '../../data/firebase_storage/image_storage.dart';

class ProfileEditor extends StatefulWidget {
  const ProfileEditor({super.key, @required this.docs});

  final dynamic docs;

  @override
  State<ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  File? selectImage;
  XFile? fileName;
  ImageStorage imageStorage = ImageStorage();

  ProfileCollection profileCollection = ProfileCollection();

  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    implementController();
    super.initState();
  }

  void implementController() {
    surnameController.text = widget.docs["surname"];
    nameController.text = widget.docs["name"];
    phoneController.text = widget.docs["phone"];
  }

  selectImageGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      fileName = returnImage;
      selectImage = File(returnImage!.path);
    });
  }

  void pushStorage() async {
    await imageStorage.addImageStorage(fileName!);
  }

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
                    child: widget.docs["image"] == ""
                        ? IconButton(
                            onPressed: () async {
                              selectImageGallery();
                              if (selectImage != null) {
                                pushStorage();
                                await Future.delayed(
                                    const Duration(seconds: 5));
                                await profileCollection.editProfileImage(
                                    widget.docs, imageStorage.imagePathURL!);
                                initState();
                              }
                            },
                            icon: const Icon(
                              Icons.add_photo_alternate_rounded,
                              color: regular,
                              size: 50,
                            ))
                        : GestureDetector(
                            onTap: () async {
                              selectImageGallery();
                              if (selectImage != null) {
                                pushStorage();
                                await Future.delayed(
                                    const Duration(seconds: 5));
                                await profileCollection.editProfileImage(
                                    widget.docs, imageStorage.imagePathURL!);
                                initState();
                              }
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.docs['image']),
                              radius: 40,
                            ),
                          ),
                  ),
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
                  ElevatedButton(
                    onPressed: () {},
                    style: accentButton,
                    child: Text(
                      "Запросить новый пароль",
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                profileCollection.editProfile(
                    widget.docs,
                    surnameController.text,
                    nameController.text,
                    phoneController.text);

                Navigator.pop(context);

                Toast.show("Сохранено");
              },
              style: accentButton_2,
              child: Text(
                "Сохранить",
                style: labelStyle,
              )),
        ],
      ),
    );
  }
}
