import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/admin/upload.dart';

import 'Booklist.dart';

class AdminArea extends StatefulWidget {
  const AdminArea({Key? key}) : super(key: key);

  @override
  _AdminAreaState createState() => _AdminAreaState();
}

class _AdminAreaState extends State<AdminArea> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("صلاحيات نسئول النظام"),
          ),
          body: Container(),
          drawer: SafeArea(
            child: Drawer(
              elevation: 2.3,
              child: ListView(
                // header
                children: [
                  DrawerHeader(
                    //container with alignment.center
                    decoration: BoxDecoration(color: Colors.green.shade200),
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Center(
                          child: Text(
                            "صلاحيات مسئول النظام",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),

                      ],
                    ),
                  ) ,
                  Container(
                    color: Colors.green.shade200,
                    child:Column(
                      children: [
                        Divider(height: 1,thickness: 0,),
                        ListTile(
                          leading: Icon(Icons.save),
                          title: Text("ادخال بيانات الكتب"),
                          contentPadding: EdgeInsets.symmetric(horizontal: 35,vertical: 0),
                          dense: true,
                          onTap: () async{

                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => Upload(),));
                          },
                        ),
                        Divider(height: 1,thickness: 0,),
                        ListTile(
                          leading: Icon(Icons.save),
                          title: Text("قائمة الكتب"),
                          contentPadding: EdgeInsets.symmetric(horizontal: 35,vertical: 0),
                          dense: true,
                          onTap: () async{

                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => Booklist(),));
                          },
                        ),
                      ],
                    )

                  )
                  //he

                ],
              ),
            ),
          ),
        )
    );
  }
}
