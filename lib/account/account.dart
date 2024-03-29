import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';

class account {
  static String? fname_;
  static String? lname_;
  static String? email_;
  static String? pass_;
  static String? num_;
  static List<bool>? mysportdata_ = [
    false,
    false,
    false,
    false,
    false,
  ];
  static List<String> qr_data = [];
  static LocationData? livelocation;
  static bool? user_;
  static List? sports_data;
  static List<String>? images;
  static List<String>? list_;
  static List<List> v1 = [];
  static List<List> v2 = [];
  static List<List> v3 = [];
  static List<List> v4 = [];
  static List<List> v5 = [];
  static List<Marker> m1 = [];
  static List<Marker> m2 = [];
  static List<Marker> m3 = [];
  static List<Marker> m4 = [];
  static List<Marker> m5 = [];
  static Color color_1 = HexColor("#0B5269");
  static Color color_2 = HexColor("#02B5D9");
  static Color color_3 = HexColor("#F4F7FB");

  String? fname;
  String? lname;
  String? email;
  String? pass;
  String? num;
  bool? user;
  String? l_1;
  String? l_2;
  List<String>? list;
  List<bool>? mysportdata;

  account({
    this.fname,
    this.lname,
    this.email,
    this.pass,
    this.num,
    this.user,
    this.l_1,
    this.l_2,
    this.list,
    this.mysportdata,
  });

  account.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    pass = json['pass'];
    num = json['num'];
    user = json['user'];
    list = json['list'];
    l_1 = json['l_1'];
    l_2 = json['l_2'];
    mysportdata = json['mysportdata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['pass'] = this.pass;
    data['num'] = this.num;
    data['user'] = this.user;
    data['l_1'] = this.l_1;
    data['l_2'] = this.l_2;
    data['list'] = this.list;
    data['mysportdata'] = this.mysportdata;
    return data;
  }
}

class data_ {
  String? uid;
  String? location_1;
  String? location_2;
  List<String>? images;

  data_({this.uid, this.location_1, this.location_2, this.images});

  data_.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    location_1 = json['location_1'];
    location_2 = json['location_1'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['location_1'] = this.location_1;
    data['location_2'] = this.location_2;
    data['images'] = this.images;
    return data;
  }
}

class fun {
  static Future<bool> checkInternet() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String?> get_address(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    Placemark place = placemarks[0];
    if (place.street!.isNotEmpty) {
      return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
    } else {
      return '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
    }
  }

  static get_marker() async {
    List x;
    await FirebaseFirestore.instance
        .collection(account.sports_data![0]['name'])
        .get()
        .then((value) => {
              for (int j = 0; j < value.docs.length; j++)
                {
                  x = [],
                  x.add(value.docs[j].data()['location_1'].toString()),
                  x.add(value.docs[j].data()['location_2'].toString()),
                  x.add(value.docs[j].data()['images']),
                  x.add(value.docs[j].data()['uid']),
                  account.v1.add(x),
                }
            });
    await FirebaseFirestore.instance
        .collection(account.sports_data![1]['name'])
        .get()
        .then((value) => {
              for (int j = 0; j < value.docs.length; j++)
                {
                  x = [],
                  x.add(value.docs[j].data()['location_1'].toString()),
                  x.add(value.docs[j].data()['location_2'].toString()),
                  x.add(value.docs[j].data()['images']),
                  x.add(value.docs[j].data()['uid']),
                  account.v2.add(x),
                }
            });
    await FirebaseFirestore.instance
        .collection(account.sports_data![2]['name'])
        .get()
        .then((value) => {
              for (int j = 0; j < value.docs.length; j++)
                {
                  x = [],
                  x.add(value.docs[j].data()['location_1'].toString()),
                  x.add(value.docs[j].data()['location_2'].toString()),
                  x.add(value.docs[j].data()['images']),
                  x.add(value.docs[j].data()['uid']),
                  account.v3.add(x),
                }
            });
    await FirebaseFirestore.instance
        .collection(account.sports_data![3]['name'])
        .get()
        .then((value) => {
              for (int j = 0; j < value.docs.length; j++)
                {
                  x = [],
                  x.add(value.docs[j].data()['location_1'].toString()),
                  x.add(value.docs[j].data()['location_2'].toString()),
                  x.add(value.docs[j].data()['images']),
                  x.add(value.docs[j].data()['uid']),
                  account.v4.add(x),
                }
            });
    await FirebaseFirestore.instance
        .collection(account.sports_data![4]['name'])
        .get()
        .then((value) => {
              for (int j = 0; j < value.docs.length; j++)
                {
                  x = [],
                  x.add(value.docs[j].data()['location_1'].toString()),
                  x.add(value.docs[j].data()['location_2'].toString()),
                  x.add(value.docs[j].data()['images']),
                  x.add(value.docs[j].data()['uid']),
                  account.v5.add(x),
                }
            });
  }

  static set_marker() async {
    for (int j = 0; j < account.v1.length; j++) {
      account.m1.add(
        Marker(
          markerId: MarkerId(account.v1[j][3]),
          index: j,
          position: LatLng(
            double.parse(
              account.v1[j][0],
            ),
            double.parse(
              account.v1[j][1],
            ),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
    for (int j = 0; j < account.v2.length; j++) {
      account.m2.add(
        Marker(
          markerId: MarkerId(account.v2[j][3]),
          index: j,
          position: LatLng(
            double.parse(
              account.v2[j][0],
            ),
            double.parse(
              account.v2[j][1],
            ),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
    for (int j = 0; j < account.v3.length; j++) {
      account.m3.add(
        Marker(
          markerId: MarkerId(account.v3[j][3]),
          index: j,
          position: LatLng(
            double.parse(
              account.v3[j][0],
            ),
            double.parse(
              account.v3[j][1],
            ),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
    for (int j = 0; j < account.v4.length; j++) {
      account.m4.add(
        Marker(
          markerId: MarkerId(account.v4[j][3]),
          index: j,
          position: LatLng(
            double.parse(
              account.v4[j][0],
            ),
            double.parse(
              account.v4[j][1],
            ),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
    for (int j = 0; j < account.v5.length; j++) {
      account.m5.add(
        Marker(
          markerId: MarkerId(account.v5[j][3]),
          index: j,
          position: LatLng(
            double.parse(
              account.v5[j][0],
            ),
            double.parse(
              account.v5[j][1],
            ),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
  }
}
