

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase.dart';

class Client3 extends StatefulWidget{
  @override
  Client3State createState() => Client3State();

}

class Client3State extends State<Client3>{
  String ClientID = "pneJtghqpHFUE19cNGeM";
  String ClientName = "client-3";
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(child: Text(ClientName),),
        Center(child: Text("Request"),),
        showrequest(),
        Center(child: Text("Book a appointment"),),
        showadmin(),

      ],
    );
  }

  showrequest() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("appointment").where("clientid", isEqualTo: ClientID).snapshots(),
        builder: (context,snap) {
          print("jj");

          if(snap.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snap.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(snap.data?.docs[index]['admindata']['name']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              margin:EdgeInsets.all(10.0),
                              child: Text(snap.data?.docs[index]['status'])),
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

  showadmin() {
    return FutureBuilder(
      future: Firebasehelper.getAdmindata(), builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: Text("Checking admins"));
      } else if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData && snapshot.data!.length > 0) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context,int index){
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(snapshot.data![index]!['name']),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: ()=>{
                              Firebasehelper.bookAppointment(ClientID, snapshot.data![index]!['id'],{"name":ClientName},{"name":snapshot.data![index]!['name']})
                            },
                            child: Container(
                              margin:EdgeInsets.all(10.0),
                              child: Text("Book"),
                              color: Colors.green,
                            )),
                      ],
                    )
                  ],
                ),
              );
            },
          );

        } else {
          return Container(
            color: Colors.green,
            height: 50,
            child: Center(child: Text("No Admins available")),
          );
        }
      }
      return Container();
    },
    );
  }

  Future<int> getData() {
    return Future.delayed(Duration(seconds: 2), () {
      return 1;
      // throw Exception("Custom Error");
    });
  }

}