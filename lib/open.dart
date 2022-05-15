import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin/adminarea.dart';

class Open extends StatefulWidget {
  const Open({Key? key}) : super(key: key);

  @override
  _OpenState createState() => _OpenState();
}

class _OpenState extends State<Open> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120,bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/yyyyyyyy.jpg",
                      width: 450,
                      height: 200,
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "تطبيق المكتبة الالكترونية",
                  style: TextStyle(fontSize: 20 ,fontFamily: "Yel",color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),

                    child: ElevatedButton.icon(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2, color: Colors.red),
                            primary: Colors.white

                        ),
                        onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminArea()));
                        },
                        icon: Icon(Icons.person),
                        label: Text("مدير النظام",style: TextStyle(fontSize: 20),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                    child: ElevatedButton.icon(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2, color: Colors.red),
                            primary: Colors.white

                        ),
                        onPressed: () {
                  //        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomerReg()));

                        },
                        icon: Icon(Icons.assistant_outlined),
                        label: Text("المستخدم",style: TextStyle(fontSize: 20),)
                    ),
                  ),
                ],
              ),

              Center(
                  child: Text(
                    "تطبيقنا هى منصة عربية توفر كورسات عاليةالجودة فى",
                    style: TextStyle(fontSize: 12, fontFamily: "Yel",color: Colors.grey),
                  )),
              Center(
                  child: Text(
                    "    مختلف المجالات والتخصصات "
                    ,
                    style: TextStyle(fontSize: 12, fontFamily: "Yel",color: Colors.grey),
                  )),
              Center(
                  child: Text(

                    " تسعى الى رفع مستوى الثقافة فى الوطن العربى",
                    style: TextStyle(fontSize: 12, fontFamily: "Yel",color: Colors.grey),
                  )),

            ],
          ),
        )
    );
  }
}
