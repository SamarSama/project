import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/Models/book.dart';
import 'package:url_launcher/url_launcher.dart';

class Booklist extends StatefulWidget {
  const Booklist({Key? key}) : super(key: key);

  @override
  _BooklistState createState() => _BooklistState();
}

class _BooklistState extends State<Booklist> {
  late DatabaseReference base, base1;
  late FirebaseDatabase database, database1;
  late FirebaseApp app, app1;
  String? task;
   bool isLoading=false;
  late bool _permissionReady;
  late String _localPath;
  ReceivePort _port = ReceivePort();

  List<Book> BookList = [];
  List<String> bookkey = [];
  String user = "admin";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookListFun();
  }
  @override
  void initState() {
    super.initState();
    isLoading = true;
    _permissionReady = false;

_prepareSaveDir();

  }

  void _launchUrl(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void bookListFun() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("books");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Book p = Book.fromJson(event.snapshot.value);
      BookList.add(p);
      bookkey.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == "admin") {
      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text("قائمة الكتب"),
              backgroundColor: Colors.blue.shade200,
            ),
            body: ListView.builder(
                itemCount: BookList.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>vechileList(CompanyList[index],keyslist[index])));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    children: [
                                      Text(BookList[index].bookname.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          )),
                                      Text(BookList[index].dar.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          )),
                                      Center(
                                          child: Text(
                                            " تاريخ النشر ${BookList[index]
                                                .publistdate.toString()} ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          )),
                                    ],
                                  )),
                              Expanded(
                                child: Container(
                                  width: 20,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          BookList[index].bookcover.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  /* add child content here */
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.lightBlue.shade200),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors
                                                      .lightBlue.shade200)))),
                                  onPressed: () {
                                    log(BookList[index]
                                        .file.toString());
                                    if(BookList[index]
                                        .file==null)
                                      {
                                        print("is null");
                                        return;
                                      }
                                    _launchUrl(BookList[index]
                                        .file.toString());
                                  },
                                  icon: Icon(Icons.assistant_outlined),
                                  label: Text(
                                    "تحميل الكتاب",
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ));
    } else {
      return Container(

      );
    }
    // return Directionality(
    //     textDirection: TextDirection.rtl,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: Text("قائمة الحافلات"),
    //         backgroundColor: Colors.green.shade200,
    //       ),
    //       body: ListView.builder(
    //           itemCount: vechileList.length,
    //           itemBuilder: (_, index) {
    //             return InkWell(
    //               onTap: () {
    //                 // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>vechileList(CompanyList[index],keyslist[index])));
    //               },
    //               child: Card(
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                             child: Column(
    //                               children: [
    //                                 Text(vechileList[index].type.toString(),
    //                                     style: TextStyle(
    //                                       fontSize: 20.sp,
    //                                       color: Colors.black,
    //                                     )),
    //                                 Text(vechileList[index].vechilenum.toString(),
    //                                     style: TextStyle(
    //                                       fontSize: 20.sp,
    //                                       color: Colors.black,
    //                                     )),
    //                                 Center(
    //                                     child: Text(
    //                                       " حمولة السيارة ${vechileList[index].heavybykelo.toString()} كيلو",
    //                                       style: TextStyle(
    //                                         fontSize: 20.sp,
    //                                         color: Colors.black,
    //                                       ),
    //                                     )),
    //                               ],
    //                             )),
    //                         Expanded(
    //                           child: Container(
    //                             width: 20.w,
    //                             height: 120.h,
    //                             decoration: BoxDecoration(
    //                               color: Colors.blueAccent,
    //                               shape: BoxShape.rectangle,
    //                               borderRadius: BorderRadius.all(
    //                                   Radius.circular(90.0.r)),
    //                               image: DecorationImage(
    //                                 image: NetworkImage(
    //                                     vechileList[index].image.toString()),
    //                                 fit: BoxFit.cover,
    //                               ),
    //                             ),
    //                             /* add child content here */
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     Container(
    //                       width: 170.w,
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: 10, vertical: 10),
    //                         child: ElevatedButton.icon(
    //                             style: ButtonStyle(
    //                                 backgroundColor:
    //                                 MaterialStateProperty.all<Color>(
    //                                     Colors.lightBlue.shade200),
    //                                 shape: MaterialStateProperty.all<
    //                                     RoundedRectangleBorder>(
    //                                     RoundedRectangleBorder(
    //                                         borderRadius:
    //                                         BorderRadius.circular(18.0),
    //                                         side: BorderSide(
    //                                             color: Colors
    //                                                 .lightBlue.shade200)))),
    //                             onPressed: () async{
    //                               app1 = await Firebase.initializeApp();
    //                               database1 = FirebaseDatabase(app: app);
    //                               base1 = database.reference().child("veichles");
    //                               base1.child(widget.keyslist).child(vechilekey[index])
    //                                   .remove().whenComplete(() {
    //                                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VechileList(widget.keyslist)));
    //                               });
    //                             },
    //                             icon: Icon(Icons.assistant_outlined),
    //                             label: Text(
    //                               "حذف ",
    //                               style: TextStyle(fontSize: 20.sp),
    //                             )),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           }),
    //     ));  }
  }




  Future<bool> _openDownloadedFile(String? task) {
    if (task != null) {
      return FlutterDownloader.open(taskId: task);
    } else {
      return Future.value(false);
    }
  }



  Future<Null> _prepare(String url) async {

    String dir = (await getApplicationDocumentsDirectory()).path;

    log(dir.toString());
    log("//////////////");
     task = await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    ).then((value) {
       print(value.toString());
     });

  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }
}
