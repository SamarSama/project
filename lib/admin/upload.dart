import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Models/book.dart';

import 'adminarea.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? image1, image2, file;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference refStorage;

  late FirebaseDatabase database;
  late FirebaseApp app;
  late DatabaseReference base;
  late String _bookname,
      _authername,
      _autherage,
      _authercity,
      _authereducation,
      _dar,
      _date,
      _cat;
  TextEditingController booknamecon = TextEditingController();
  TextEditingController authernamecon = TextEditingController();
  TextEditingController autheragecon = TextEditingController();
  TextEditingController authercitycon = TextEditingController();
  TextEditingController authereducationcon = TextEditingController();
  TextEditingController darcon = TextEditingController();
  TextEditingController datecon = TextEditingController();
  TextEditingController catcon = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future Pickimage1() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    this.image1 = File(image.path);
    setState(() {});
  }

  void uploadBookFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File f = File(result.files.single.path!);
      setState(() {
        file = f;
      });
    } else {
      // User canceled the picker
    }
  }

  Future Pickimage2() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    this.image2 = File(image.path);
    setState(() {});
  }

  // Future Pickfile() async {
  //
  //   final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if(image==null)
  //   {
  //     return;
  //   }
  //
  //   this.imagge=File(image.path);
  //   setState(() {
  //
  //   });
  //
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(" ?????? ???????????? ???????????? ?? ???????? ????????????"),
        ),
        body: Form(
          key: _formkey,
          child: Container(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      "???????? ???????????? ????????????",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade200),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Colors.green.shade200)))),
                        onPressed: () async {
                          await Pickimage1();
                        },
                        label: Text("???????? ???????? ???????? ????????????"),
                        icon: Icon(Icons.image),
                      )),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Image.file(
                        image1 ?? File(""),
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/images/yyyyyyyy.jpg"),
                      ),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade200),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Colors.green.shade200)))),
                        onPressed: () async {
                           uploadBookFile();
                        },
                        label: Text("???????? ?????? ????????????"),
                        icon: Icon(Icons.book),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(file?.path ?? "???? ?????? ?????????? ??????????"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "?????? ????????????";
                          }
                          return null;
                        },
                        onSaved: (bookname) {
                          _bookname = bookname!;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: booknamecon,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '?????? ????????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '?????? ????????????',
                          labelStyle: TextStyle(color: Colors.blue),
                          prefixIcon: const Icon(
                            Icons.ac_unit_outlined,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "?????? ??????????";
                          }
                          return null;
                        },
                        onSaved: (dar) {
                          _dar = _dar;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: darcon,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '?????? ??????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '?????? ??????????',
                          labelStyle: TextStyle(color: Colors.blue),
                          prefixIcon: const Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "??????????????";
                          }
                          return null;
                        },
                        onSaved: (date) {
                          _date = date!;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: datecon,
                        keyboardType: TextInputType.datetime,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '???????? ??????????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '??????????????',
                          labelStyle: TextStyle(color: Colors.blue),

                          prefixIcon: const Icon(
                            Icons.eleven_mp_outlined,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "??????????";
                          }
                          return null;
                        },
                        onSaved: (cat) {
                          _cat = cat!;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: datecon,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '???????? ??????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '??????????',
                          labelStyle: TextStyle(color: Colors.blue),

                          prefixIcon: const Icon(
                            Icons.eleven_mp_outlined,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0,
                  ),
                  Center(
                    child: Text(
                      "???????? ???????????? ????????????",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "?????? ????????????";
                          }
                          return null;
                        },
                        onSaved: (authername) {
                          _authername = authername!;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: authernamecon,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '?????? ????????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '?????? ????????????',
                          labelStyle: TextStyle(color: Colors.blue),
                          prefixIcon: const Icon(
                            Icons.border_color,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "???? ???????? ???????? ?????? ????????????";
                          }
                          return null;
                        },
                        onSaved: (age) {
                          _autherage = age!;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: autheragecon,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '???????? ?????? ????????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '?????? ????????????',
                          labelStyle: TextStyle(color: Colors.blue),
                          prefixIcon: const Icon(
                            Icons.atm_sharp,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "?????? ???????????? ????????????";
                          }
                          return null;
                        },
                        onSaved: (city) {
                          _authercity = city!;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: authercitycon,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '???????? ?????? ????????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '?????? ????????????',
                          labelStyle: TextStyle(color: Colors.blue),
                          prefixIcon: const Icon(
                            Icons.atm_sharp,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "???????? ????????????";
                          }
                          return null;
                        },
                        onSaved: (education) {
                          _authereducation = education!;
                        },
                        style: TextStyle(fontFamily: "Arial"),
                        controller: authereducationcon,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          hintText: '???????? ????????????',
                          hintStyle: TextStyle(color: Colors.blue),
                          labelText: '???????? ????????????',
                          labelStyle: TextStyle(color: Colors.blue),
                          prefixIcon: const Icon(
                            Icons.atm_sharp,
                            color: Colors.blue,
                          ),
                          //prefixText: ' ',
                          //suffixText: 'USD',
                          //suffixStyle: const TextStyle(color: Colors.green)),
                        )),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade200),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Colors.green.shade200)))),
                        onPressed: () async {
                          await Pickimage2();
                        },
                        label: Text("???????? ???????? ????????????"),
                        icon: Icon(Icons.person),
                      )),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Image.file(
                        image2 ?? File(""),
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/images/auther.png"),
                      ),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade200),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Colors.green.shade200)))),
                        onPressed: () async {
                          if (file == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("???? ?????????????? ?????????? ????????")));
                            return;
                          }
                          if (_formkey.currentState!.validate()) {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: Text('?????????? ????????????????'),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                );
                              },
                            );
                            app = await Firebase.initializeApp();
                            database = FirebaseDatabase(app: app);
                            base = database.reference().child("books");
                            refStorage =
                                storage.ref('/project_images').child("images");
                            refStorage
                                .child(DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString())
                                .putFile(file!)
                                .then((bookFile) {
                              refStorage
                                  .child(DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString())
                                  .putFile(image1!)
                                  .then((p1) => {
                                        refStorage
                                            .child(DateTime.now()
                                                .microsecondsSinceEpoch
                                                .toString())
                                            .putFile(image2!)
                                            .then((p2) async {
                                          String image1 =
                                              await p1.ref.getDownloadURL();
                                          String image2 =
                                              await p2.ref.getDownloadURL();
                                          String file = await bookFile.ref
                                              .getDownloadURL();
                                          String bookname = booknamecon.text
                                              .toString()
                                              .trim();
                                          String dar =
                                              darcon.text.toString().trim();
                                          String cat =
                                              catcon.text.toString().trim();
                                          String date =
                                              datecon.text.toString().trim();
                                          String authername = authernamecon.text
                                              .toString()
                                              .trim();
                                          String autherage = autheragecon.text
                                              .toString()
                                              .trim();
                                          String authereducation =
                                              authereducationcon.text
                                                  .toString()
                                                  .trim();
                                          String city = authercitycon.text
                                              .toString()
                                              .trim();
                                          String Id = DateTime.now()
                                                  .day
                                                  .toString() +
                                              DateTime.now().hour.toString() +
                                              DateTime.now().minute.toString() +
                                              DateTime.now().second.toString() +
                                              DateTime.now()
                                                  .millisecond
                                                  .toString();

                                          Book v = Book(
                                              id: Id,
                                              autherage: autherage,
                                              autherimage: image2,
                                              authername: authername,
                                              education: authereducation,
                                              city: city,
                                              bookcover: image1,
                                              bookname: bookname,
                                              dar: dar,
                                              file: file,
                                              publistdate: date

                                              // rate: ratingEnd
                                              );
                                          base
                                              .child(Id)
                                              .set(v.toJson())
                                              .whenComplete(() {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdminArea()));
                                          });
                                        }),
                                      });
                            });
                          } else {
                            print("??????");
                          }
                        },
                        child: Text(
                          "???????? ????????????????",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
