import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_cricket/account/account.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class booking_details {
  static LatLng? next;
  static String? address;
  static DateTime? a_time;
  static DateTime? a_date;
  static DateTime? l_time;
  static DateTime? l_date;
  static String? sportsname = account.sports_data![0]['name'];
  static int sport_type = 1;
  static Duration? difference;
  static double? amount;
  static Marker? marker;

  static Future<bool> add_data(BuildContext context) async {
    if (await fun.checkInternet()) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String a_time =
          '${a_date!.day}/${a_date!.month} - ${TimeOfDay(hour: booking_details.a_time!.hour, minute: booking_details.a_time!.minute).format(context)}';
      String l_time =
          '${l_date!.day}/${l_date!.month} - ${TimeOfDay(hour: booking_details.l_time!.hour, minute: booking_details.l_time!.minute).format(context)}';
      String g_id = marker!.markerId.value.toString();
      String? g_num;
      double a = 1234;
      String? random =
          "myboxcricket$a$a_time$a$l_time${booking_details.address}";
      var hashedPassword = DBCrypt().hashpw(random, DBCrypt().gensalt());
      random = hashedPassword;
      DatabaseReference db = FirebaseDatabase.instance.ref();
      await FirebaseFirestore.instance
          .collection("user_data")
          .doc(g_id)
          .get()
          .then(
            (value) => {
              g_num = value.data()!.values.toList()[4],
            },
          );
      Map<String, String> data = {
        "t_id": uid,
        "g_id": g_id,
        "sports": account.sports_data![booking_details.sport_type]['name'],
        "address": booking_details.address!,
        "num": g_num!,
        "atime": a_time,
        "ltime": l_time,
        "random": random,
        'arrive': booking_details.a_time.toString(),
        "leave": booking_details.l_time.toString(),
        "amount": booking_details.amount.toString(),
      };
      bool result = false;
      await FirebaseFirestore.instance
          .collection('userdata(allbooking)')
          .doc(uid)
          .collection(uid)
          .add(data)
          .then((value) => {
                result = true,
              })
          .onError((error, stackTrace) => {
                result = false,
              });
      db = FirebaseDatabase.instance.ref("booking(user)/$uid");
      await db
          .push()
          .set(data)
          .then((value) => {
                result = true,
              })
          .onError((error, stackTrace) => {
                result = false,
              });
      data = {
        "fname": account.fname_!,
        "lname": account.lname_!,
        "t_id": uid,
        "g_id": g_id,
        "sports": account.sports_data![booking_details.sport_type]['name'],
        "address": booking_details.address!,
        "num": account.num_!,
        "atime": a_time,
        "ltime": l_time,
        "random": random,
        'arrive': booking_details.a_time.toString(),
        "leave": booking_details.l_time.toString(),
        "amount": booking_details.amount.toString(),
      };
      await FirebaseFirestore.instance
          .collection('user_data(allbooking)')
          .doc(g_id)
          .collection(g_id)
          .add(data)
          .then((value) => {
                result = true,
              })
          .onError((error, stackTrace) => {
                result = false,
              });
      db = FirebaseDatabase.instance.ref("booking/${marker!.markerId.value}");
      await db
          .push()
          .set(data)
          .then((value) => {
                result = true,
              })
          .onError((error, stackTrace) => {
                result = false,
              });
      data = {
        "t_id": uid,
        "sports": account.sports_data![booking_details.sport_type]['name'],
        "random": random,
        'arrive': booking_details.a_time.toString(),
        "leave": booking_details.l_time.toString(),
      };
      await FirebaseFirestore.instance
          .collection('bookslots')
          .doc(g_id)
          .collection(sportsname!)
          .add(data)
          .then((value) => {
                result = true,
              })
          .onError((error, stackTrace) => {
                result = false,
              });
      return result;
    } else {
      Fluttertoast.showToast(msg: "Your Internet connection");
      return false;
    }
  }
}

class getbookslots {
  String? arrive;
  String? leave;
  String? random;
  String? sports;
  String? tId;

  getbookslots({this.arrive, this.leave, this.random, this.sports, this.tId});

  getbookslots.fromJson(Map<String, dynamic> json) {
    arrive = json['arrive'];
    leave = json['leave'];
    random = json['random'];
    sports = json['sports'];
    tId = json['t_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arrive'] = this.arrive;
    data['leave'] = this.leave;
    data['random'] = this.random;
    data['sports'] = this.sports;
    data['t_id'] = this.tId;
    return data;
  }
}
