import 'dart:io';

import 'package:flutter/material.dart';
import 'package:galleryapp/full_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

ValueNotifier<List> database = ValueNotifier([]);

class Gpage extends StatelessWidget {
  const Gpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 227, 233, 232),
              Color.fromARGB(255, 226, 230, 227)
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 19, 22, 21),
          onPressed: () async {
            final image =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (image == null) {
              return;
            } else {
              Directory? directory = await getExternalStorageDirectory();
              File imagepath = File(image.path);

              await imagepath.copy('${directory!.path}/${DateTime.now()}.jpg');

              getid(directory);
            }
          },
          child: const Icon(Icons.camera_alt_outlined),
        ),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromARGB(255, 241, 245, 244),
                    Color.fromARGB(255, 232, 238, 234)
                  ]),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'My Gallery',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: database,
          builder: (context, List data, anything) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: GridView.extent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                  data.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                Fullpage(image: data[index], tagForHero: index),
                          ),
                        );
                      },
                      child: Hero(
                        tag: index,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(
                                  File(
                                    data[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

getid(Directory directory) async {
  final listDir = await directory.list().toList();
  database.value.clear();
  for (var i = 0; i < listDir.length; i++) {
    if (listDir[i].path.substring(
            (listDir[i].path.length - 4), (listDir[i].path.length)) ==
        '.jpg') {
      database.value.add(listDir[i].path);
      database.notifyListeners();
    }
  }
}
