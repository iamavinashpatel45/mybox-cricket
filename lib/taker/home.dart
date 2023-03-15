import 'dart:async';
import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/drawer/drawer.dart';
import 'package:crave_cricket/sliderimages.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:upi_india/upi_india.dart';
import '../taker/datetime_picker/datetime_picker_arrive.dart';
import 'booking_details.dart';

class t_home extends StatefulWidget {
  final int setmarker;

  const t_home({super.key, required this.setmarker});

  @override
  State<t_home> createState() => _t_homeState();
}

class _t_homeState extends State<t_home> {
  double min_height = 0;
  int index = 0;
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  Color color = HexColor("#155E83");
  GoogleMapController? _controller;
  LocationData? livelocation;
  List<Marker>? marker;
  static List<List> v = [];

  go_on_marker(LatLng latLng, Marker marker, int i) async {
    index = i;
    booking_details.address = await fun.get_address(latLng);
    booking_details.marker = marker;
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 17,
        ),
      ),
    );
    setState(() {
      min_height = 150;
      booking_details.next = latLng;
    });
  }

  // ignore: non_constant_identifier_names
  add_ontap() {
    int x = marker!.length;
    for (int i = 0; i < x; i++) {
      marker![i].onTap = () {
        go_on_marker(
          marker![i].position,
          marker![i],
          marker![i].index!,
        );
      };
    }
  }

  getupiapps() {
    UpiIndia _upiIndia = UpiIndia();
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        booking_details.apps = value;
      });
    }).catchError((e) {
      booking_details.apps = [];
    });
  }

  Future getlocation() async {
    add_ontap();
    getupiapps();
    Location location = Location();
    await location.getLocation().then((location) => {
          setState(() {
            livelocation = location;
            account.livelocation = location;
          })
        });
  }

  _fun() {
    if (widget.setmarker == 1) {
      marker = account.m1;
      v = account.v1;
    } else if (widget.setmarker == 2) {
      marker = account.m2;
      v = account.v2;
    } else if (widget.setmarker == 3) {
      marker = account.m3;
      v = account.v3;
    } else if (widget.setmarker == 4) {
      marker = account.m4;
      v = account.v4;
    } else {
      marker = account.m5;
      v = account.v5;
    }
  }

  @override
  void initState() {
    _fun();
    getlocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return livelocation == null
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo__.png",
                    scale: 1.8,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SpinKitThreeBounce(
                    color: color,
                    size: 50.0,
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            key: _drawerscaffoldkey,
            drawer: const drawer(
              type: true,
            ),
            body: SlidingUpPanel(
              maxHeight: 300,
              minHeight: min_height,
              panel: Container(
                height: 150,
                color: Colors.black.withOpacity(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    booking_details.next != null
                        ? Material(
                            elevation: 10,
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        booking_details.address!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: color,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            alignment: Alignment.centerLeft,
                                            child:
                                                const datetime_picker_arrive(),
                                            type: PageTransitionType.size,
                                            duration: const Duration(
                                              milliseconds: 500,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Book',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 0,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        dashPattern: const [10, 4],
                        child: sliderimages(
                          images: v[index][2],
                          type: false,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    // onTap: (LatLng l) {
                    //   print(fun.get_address(l));
                    // },
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: marker!.map((e) => e).toSet(),
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            livelocation!.latitude!, livelocation!.longitude!),
                        zoom: 15),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: InkWell(
                      onTap: () {
                        _drawerscaffoldkey.currentState!.openDrawer();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            )),
                        child: Center(
                          child: Icon(
                            Icons.menu,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
