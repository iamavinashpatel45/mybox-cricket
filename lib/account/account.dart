import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class account {
  static String? fname_;
  static String? lname_;
  static String? email_;
  static String? pass_;
  static String? num_;
  static List<String> qr_data = [];
  static LocationData? livelocation;
  static bool? user_;
  static List<String>? images;
  static List? data_vehicle;
  static List<String>? list_;
  static List<List> v = [];
  static List<Marker> marker = [];

  String? fname;
  String? lname;
  String? email;
  String? pass;
  String? num;
  bool? user;
  String? l_1;
  String? l_2;
  List<String>? list;

  account(
      {this.fname,
      this.lname,
      this.email,
      this.pass,
      this.num,
      this.user,
      this.l_1,
      this.l_2,
      this.list});

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
    print(place);
    if (place.locality!.isEmpty || place.thoroughfare!.isEmpty) {
      return '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}';
    } else {
      return '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
    }
  }

  static get_marker() async {
    List x;
    await FirebaseFirestore.instance.collection("data").get().then((value) => {
          for (int j = 0; j < value.docs.length; j++)
            {
              x = [],
              x.add(value.docs[j].data()['location_1'].toString()),
              x.add(value.docs[j].data()['location_2'].toString()),
              x.add(value.docs[j].data()['images']),
              x.add(value.docs[j].data()['uid']),
              account.v.add(x),
            }
        });
    // await FirebaseFirestore.instance.collection("v_2").get().then((value) => {
    //       for (int j = 0; j < value.docs.length; j++)
    //         {
    //           x = [],
    //           x.add(value.docs[j].data()['location_1'].toString()),
    //           x.add(value.docs[j].data()['location_2'].toString()),
    //           x.add(value.docs[j].data()['num']),
    //           x.add(value.docs[j].data()['uid']),
    //           account.v_2.add(x),
    //         }
    //     });
    // await FirebaseFirestore.instance.collection("v_3").get().then((value) => {
    //       for (int j = 0; j < value.docs.length; j++)
    //         {
    //           x = [],
    //           x.add(value.docs[j].data()['location_1'].toString()),
    //           x.add(value.docs[j].data()['location_2'].toString()),
    //           x.add(value.docs[j].data()['num']),
    //           x.add(value.docs[j].data()['uid']),
    //           account.v_3.add(x),
    //         }
    //     });
    // await FirebaseFirestore.instance.collection("v_4").get().then((value) => {
    //       for (int j = 0; j < value.docs.length; j++)
    //         {
    //           x = [],
    //           x.add(value.docs[j].data()['location_1'].toString()),
    //           x.add(value.docs[j].data()['location_2'].toString()),
    //           x.add(value.docs[j].data()['num']),
    //           x.add(value.docs[j].data()['uid']),
    //           account.v_4.add(x),
    //         }
    //     });
    // await FirebaseFirestore.instance.collection("v_5").get().then((value) => {
    //       for (int j = 0; j < value.docs.length; j++)
    //         {
    //           x = [],
    //           x.add(value.docs[j].data()['location_1'].toString()),
    //           x.add(value.docs[j].data()['location_2'].toString()),
    //           x.add(value.docs[j].data()['num']),
    //           x.add(value.docs[j].data()['uid']),
    //           account.v_5.add(x),
    //         }
    //     });
    // await FirebaseFirestore.instance.collection("v_6").get().then((value) => {
    //       for (int j = 0; j < value.docs.length; j++)
    //         {
    //           x = [],
    //           x.add(value.docs[j].data()['location_1'].toString()),
    //           x.add(value.docs[j].data()['location_2'].toString()),
    //           x.add(value.docs[j].data()['num']),
    //           x.add(value.docs[j].data()['uid']),
    //           account.v_6.add(x),
    //         }
    //     });
    // // String x_ = "v_" + (i + 1).toString();
    // // await FirebaseFirestore.instance
    // //     .collection(x_)
    // //     .get()
    // //     .then((value) => {
    // //           for (int j = 0; j < value.docs.length; j++)
    // //             {
    // //               y = value.docs[j].data()['location_1'].toString(),
    // //               z = value.docs[j].data()['location_2'].toString(),
    // //               account.v_count[i].add(y),
    // //               account.v_count[i].add(z),
    // //               account.v_count[i].add(value.docs[j].data()['num']),
    // //               account.v_count[i].add(value.docs[j].data()['uid']),
    // //               account.v_count[i].add("go_on_marker(" +
    // //                   "LatLng(" +
    // //                   y +
    // //                   "," +
    // //                   z +
    // //                   ")" +
    // //                   ")"),
    // //             }
    // //         });
  }

  static set_marker() async {
    for (int j = 0; j < account.v.length; j++) {
      account.marker.add(
        Marker(
          markerId: MarkerId(account.v[j][3]),
          index: j,
          position: LatLng(
            double.parse(
              account.v[j][0],
            ),
            double.parse(
              account.v[j][1],
            ),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
    // for (int j = 0; j < account.v_2.length; j++) {
    //   account.m_2.add(Marker(
    //       markerId: MarkerId(account.v_2[j][3]),
    //       position: LatLng(
    //           double.parse(account.v_2[j][0]), double.parse(account.v_2[j][1])),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //           BitmapDescriptor.hueAzure)));
    // }
    // for (int j = 0; j < account.v_3.length; j++) {
    //   account.m_3.add(Marker(
    //       markerId: MarkerId(account.v_3[j][3]),
    //       position: LatLng(
    //           double.parse(account.v_3[j][0]), double.parse(account.v_3[j][1])),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //           BitmapDescriptor.hueAzure)));
    // }
    // for (int j = 0; j < account.v_4.length; j++) {
    //   account.m_4.add(Marker(
    //       markerId: MarkerId(account.v_4[j][3]),
    //       position: LatLng(
    //           double.parse(account.v_4[j][0]), double.parse(account.v_4[j][1])),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //           BitmapDescriptor.hueAzure)));
    // }
    // for (int j = 0; j < account.v_5.length; j++) {
    //   account.m_5.add(Marker(
    //       markerId: MarkerId(account.v_5[j][3]),
    //       position: LatLng(
    //           double.parse(account.v_5[j][0]), double.parse(account.v_5[j][1])),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //           BitmapDescriptor.hueAzure)));
    // }
    // for (int j = 0; j < account.v_6.length; j++) {
    //   account.m_6.add(Marker(
    //       markerId: MarkerId(account.v_6[j][3]),
    //       position: LatLng(
    //           double.parse(account.v_6[j][0]), double.parse(account.v_6[j][1])),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //           BitmapDescriptor.hueAzure)));
    // }
  }
}
