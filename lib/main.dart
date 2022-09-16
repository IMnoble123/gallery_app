import 'package:flutter/material.dart';

import 'dart:io';

import 'package:galleryapp/G_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Directory directory = Directory.fromUri(Uri.parse(
        '/storage/emulated/0/Android/data/com.example.custom_gallery/files'));
    getid(directory);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Gpage(),
    );
  }
}
