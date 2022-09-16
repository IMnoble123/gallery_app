import 'dart:io';
import 'package:flutter/material.dart';
import 'package:galleryapp/G_page.dart';

class Fullpage extends StatelessWidget {
  const Fullpage({Key? key, this.image, required this.tagForHero})
      : super(key: key);
  final dynamic image;
  final int tagForHero;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 33, 46, 43), Color.fromARGB(255, 237, 242, 239)]),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: ValueListenableBuilder(
            valueListenable: database,
            builder: (context, List data, _) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Hero(
                      tag: tagForHero,
                      child: Image.file(File(image.toString()))),
                ),
              );
            }),
      ),
    );
  }
}