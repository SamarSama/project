import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/book.dart';

class Booklist extends StatefulWidget {
  const Booklist({Key? key}) : super(key: key);

  @override
  _BooklistState createState() => _BooklistState();
}

class _BooklistState extends State<Booklist> {
  late DatabaseReference base, base1;
  late FirebaseDatabase database, database1;
  late FirebaseApp app, app1;


  List<Book> BookList = [];
  List<String> bookkey = [];
  String user = "admin";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookListFun();
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
                                  onPressed: () {},
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
}
