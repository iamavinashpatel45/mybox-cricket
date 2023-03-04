import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_cricket/account/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_response.dart';

class booking_details {
  static LatLng? next;
  static String? address;
  static DateTime? a_time;
  static DateTime? a_date;
  static DateTime? l_time;
  static DateTime? l_date;
  static Duration? difference;
  static double? amount;
  static UpiResponse? transactiondetails;
  static List<UpiApp>? apps;
  static Marker? marker;

  static Future<bool> add_data(BuildContext context) async {
    if (await fun.checkInternet()) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String? vehical, vehical_path;
      String a_time =
          '${a_date!.day}/${a_date!.month} - ${TimeOfDay(hour: booking_details.a_time!.hour, minute: booking_details.a_time!.minute).format(context)}';
      String l_time =
          '${l_date!.day}/${l_date!.month} - ${TimeOfDay(hour: booking_details.l_time!.hour, minute: booking_details.l_time!.minute).format(context)}';
      String g_id = marker!.markerId.value.toString();
      String? g_num;
      double a = 1234;
      String? random = "myboxcricket" + a.toString();
      a = a + 5;
      DatabaseReference db = FirebaseDatabase.instance.ref();
      db = FirebaseDatabase.instance.ref("booking(user)/" + uid);
      await FirebaseFirestore.instance
          .collection("user_data")
          .doc(g_id)
          .get()
          .then(
            (value) => {
              g_num = value.data()!.values.toList()[3],
            },
          );
      Map<String, String> data = {
        "t_id": uid,
        "g_id": g_id,
        "address": booking_details.address!,
        "num": g_num!,
        "atime": a_time,
        "ltime": l_time,
        "random": random,
        "ldate": booking_details.l_time.toString(),
        "amount": booking_details.amount.toString(),
      };
      bool result = false;
      await db
          .push()
          .set(data)
          .then((value) => {result = true})
          .onError((error, stackTrace) => {result = false});
      data = {
        "fname": account.fname_!,
        "lname": account.lname_!,
        "t_id": uid,
        "g_id": g_id,
        "address": booking_details.address!,
        "num": account.num_!,
        "atime": a_time,
        "ltime": l_time,
        "random": random,
        "ldate": booking_details.l_time.toString(),
        "amount": booking_details.amount.toString(),
      };
      db = FirebaseDatabase.instance
          .ref("booking/" + marker!.markerId.value.toString());
      await db
          .push()
          .set(data)
          .then((value) => {result = true})
          .onError((error, stackTrace) => {result = false});

      return result;
    } else {
      Fluttertoast.showToast(msg: "Your Internet connection");
      return false;
    }
  }
}
