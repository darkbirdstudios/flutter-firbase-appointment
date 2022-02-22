

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase.dart';

class Admin2 extends StatefulWidget{
  @override
  Admin2State createState() => Admin2State();

}

class Admin2State extends State<Admin2>{
  String AdminID = "ywuMVqELdNT5tOyXKuBz";
  String AdminName = "admin-2";
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(child: Text(AdminName),),
        Center(child: Text("Request"),),
        showrequest(),

      ],
    );
  }

  showrequest() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("appointment").where("adminid", isEqualTo: AdminID).where("status", isEqualTo: "pending").snapshots(),
        builder: (context,snap) {
          if(snap.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snap.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                print(snap.data?.docs[index].id);
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(snap.data?.docs[index]['clientdata']['name']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(onTap:(){
                            Firebasehelper.updateAppointment(snap.data?.docs[index].id, "confirmed");
                          },child: Container(margin:EdgeInsets.all(10.0),child: Text("yes"),color: Colors.green,)),
                          Container(width: 20,),
                          InkWell(onTap:(){Firebasehelper.updateAppointment(snap.data?.docs[index].id, "decline");},child: Container(child: Text("no"),color: Colors.red,))
                        ],
                      )
                    ],
                  ),
                );

              },
            );

          }return Text("null");
        }
    );
  }

  Future<int> getData() {
    return Future.delayed(Duration(seconds: 2), () {
      return 1;
      // throw Exception("Custom Error");
    });
  }

}