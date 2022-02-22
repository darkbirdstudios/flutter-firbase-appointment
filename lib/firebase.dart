import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Firebasehelper {

  static Future<List> getClientdata() async {
    List Client = [];
    CollectionReference clientdatbase =
        FirebaseFirestore.instance.collection("users");
    dynamic asd = await clientdatbase.get();
    var result = await asd.docs.map((doc) {
      var data = {};
      data['id'] = doc.id;
      data['name'] = doc.data()['name'];
      Client.add(data);
    });
    return Client;
  }

  static Future<List> getAdmindata() async {
    List Admin = [];
    CollectionReference clientdatbase =
        FirebaseFirestore.instance.collection("admin");
    dynamic asd = await clientdatbase.get();
    var result = await asd.docs.map((doc) {
      var data = {};
      data['id'] = doc.id;
      data['name'] = doc.data()['name'];
      Admin.add(data);
    });
    return Admin;
  }

  static void bookAppointment(clientid, adminid,clientdata,admindata) async {
    CollectionReference appointmentdatbase =
    FirebaseFirestore.instance.collection("appointment");
    var asd = await appointmentdatbase
        .add({"clientid": clientid,"clientdata":clientdata, "adminid": adminid,"admindata":admindata, "status": "pending"});
  }


  static void updateAppointment(appointid,status) async{
    CollectionReference appointmentdatbase =
    FirebaseFirestore.instance.collection("appointment");
    var result = await appointmentdatbase.doc(appointid).update({"status":status});
  }

}
