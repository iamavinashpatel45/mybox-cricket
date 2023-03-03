import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/sliderimages.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'home.dart';

class g_details extends StatefulWidget {
  final String? uid;
  final bool update;

  const g_details({Key? key, required this.uid, required this.update})
      : super(key: key);

  @override
  State<g_details> createState() => _g_detailsState();
}

class _g_detailsState extends State<g_details> {
  List<File> images = [];
  Color color = HexColor("#155E83");
  bool press = false;
  bool cir = false;
  bool press_but = false;
  LocationData? livelocation;
  LatLng? latLng_loacation;
  String? address;
  final _key = GlobalKey<FormState>();

  pickupimages() async {
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> add_images() async {
    final cloudinary = CloudinaryPublic("dabxbdh8k", "zurw6cwy");
    List<String> imageurls = [];
    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          images[i].path,
          folder: account.fname_! + account.lname_!,
        ),
      );
      imageurls.add(res.secureUrl);
    }
    account.images = imageurls;
    return true;
  }

  gohome() async {
    setState(() {
      press_but = true;
    });
    bool a = await add_images();
    if (a && livelocation != null) {
      // ignore: use_build_context_synchronously
      FocusScope.of(context).unfocus();
      try {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection("user_data")
            .doc(uid)
            .update(
              account(
                email: account.email_,
                num: account.num_,
                fname: account.fname_,
                lname: account.lname_,
                pass: account.pass_,
                user: false,
                l_1: latLng_loacation!.latitude.toString(),
                l_2: latLng_loacation!.longitude.toString(),
                list: account.images,
              ).toJson(),
            )
            .then((value) => {});
        await FirebaseFirestore.instance
            .collection("data")
            .doc(uid)
            .set(
              data_(
                uid: uid,
                location_1: latLng_loacation!.latitude.toString(),
                location_2: latLng_loacation!.longitude.toString(),
                images: account.images,
              ).toJson(),
            )
            .then((value) => {});
        // for (int i = 0; i < 6; i++) {
        //   if (vehicle[i][1] != 0) {
        //     String x = "v_" + (i + 1).toString();
        //     await FirebaseFirestore.instance
        //         .collection(x)
        //         .doc(uid)
        //         .set(vehicle_data(
        //                 uid: uid,
        //                 location_1: latLng_loacation!.latitude.toString(),
        //                 location_2: latLng_loacation!.longitude.toString(),
        //                 num: int.parse(vehicle[i][1]))
        //             .toJson())
        //         .then((value) => {});
        //   }
        // }
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const g_home()));
      } on FirebaseAuthException {
        setState(() {
          press_but = false;
        });
      } catch (e) {
        setState(() {
          press_but = false;
        });
        Fluttertoast.showToast(
            msg: "Something Wrong,please try after some time");
      }
    }
  }

  Future getlocation() async {
    Location location = Location();
    await location.getLocation().then((location) => {livelocation = location});
    latLng_loacation =
        LatLng(livelocation!.latitude!, livelocation!.longitude!);
    address = await fun.get_address(latLng_loacation!);
    setState(() {
      press = true;
      cir = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Enter your details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  images.isNotEmpty
                      ? sliderimages(
                          images: images,
                        )
                      : GestureDetector(
                          onTap: (() {
                            pickupimages();
                          }),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            strokeCap: StrokeCap.round,
                            dashPattern: const [10, 4],
                            child: SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.folder_open,
                                    size: 35,
                                  ),
                                  Text(
                                    "Select Product Images",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Your Parking Place Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  press == false
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              getlocation();
                              cir = true;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Tap to add your live Location"),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(address!),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  press_but
                      ? Center(
                          child: SpinKitCircle(
                            color: color,
                            size: 50.0,
                          ),
                        )
                      : Center(
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                gohome();
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 78, 120, 198),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.update ? 'Update' : 'Add Details',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
              child: cir == true
                  ? Center(
                      child: SpinKitCubeGrid(
                        color: color,
                        size: 50.0,
                      ),
                    )
                  : Container())
        ],
      ),
    );
  }
}
