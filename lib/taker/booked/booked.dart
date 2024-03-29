import 'dart:io';
import 'package:crave_cricket/account/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:ticket_material/ticket_material.dart';

class booked extends StatefulWidget {
  const booked({Key? key}) : super(key: key);

  @override
  State<booked> createState() => _bookedState();
}

class _bookedState extends State<booked> {
  Color color = account.color_1;
  bool go = true;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference db = FirebaseDatabase.instance
      .ref("booking(user)/${FirebaseAuth.instance.currentUser!.uid}");

  _delete_data(String key) async {
    DatabaseReference _db_delete = FirebaseDatabase.instance
        .ref("booking(user)/${FirebaseAuth.instance.currentUser!.uid}/$key");
    await _db_delete.remove().then((value) => () {
          go = false;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: account.color_3,
      appBar: AppBar(
        title: const Text("Booked Slot"),
        backgroundColor: color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          defaultChild: Center(
            child: SpinKitCubeGrid(
              color: color,
              size: 50.0,
            ),
          ),
          query: db,
          itemBuilder: (context, snapshot, animation, index) {
            go = true;
            DateTime.now().isBefore(
              DateTime.parse(
                snapshot.child('leave').value.toString(),
              ),
            )
                ? () {}
                : _delete_data(snapshot.key!);
            ScreenshotController screenshotController = ScreenshotController();
            return go
                ? Column(
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureFlipCard(
                          animationDuration: const Duration(milliseconds: 300),
                          axis: FlipAxis.vertical,
                          frontWidget: TicketMaterial(
                            height: 220,
                            radiusCircle: 6,
                            leftChild: leftside_up(
                              snapshot: snapshot,
                            ),
                            rightChild: rightside(
                              snapshot: snapshot,
                              side: true,
                              screenshotController: screenshotController,
                            ),
                            colorBackground: color,
                          ),
                          backWidget: TicketMaterial(
                            height: 220,
                            radiusCircle: 6,
                            leftChild: leftside_back(
                              snapshot:
                                  snapshot.child('random').value.toString(),
                              screenshotController: screenshotController,
                            ),
                            rightChild: rightside(
                              snapshot: snapshot,
                              side: false,
                              screenshotController: screenshotController,
                            ),
                            colorBackground: color,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}

class leftside_back extends StatefulWidget {
  final String snapshot;
  final ScreenshotController screenshotController;

  const leftside_back(
      {Key? key, required this.snapshot, required this.screenshotController})
      : super(key: key);
  @override
  State<leftside_back> createState() => _leftside_backState();
}

class _leftside_backState extends State<leftside_back> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Screenshot(
        controller: widget.screenshotController,
        child: QrImage(
          data: widget.snapshot,
          foregroundColor: account.color_3,
          embeddedImage: const AssetImage('assets/logo__.png'),
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: const Size(70, 70),
          ),
        ),
      ),
    );
  }
}

class leftside_up extends StatefulWidget {
  final DataSnapshot snapshot;
  const leftside_up({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<leftside_up> createState() => _leftside_upState();
}

class _leftside_upState extends State<leftside_up> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const VerticalDivider(
                color: Colors.black,
                thickness: 10,
              ),
              Expanded(
                child: Text(
                  widget.snapshot.child('address').value.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 218, 173, 37),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BASIC PASS',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: account.color_3,
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      widget.snapshot.child('sports').value.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: account.color_3,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color.fromARGB(255, 218, 173, 37),
                thickness: 2,
              ),
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: account.color_3,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Slot(time)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: account.color_3,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      " From",
                      style: TextStyle(
                        color: account.color_3,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: account.color_3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        widget.snapshot.child('atime').value.toString(),
                        style: TextStyle(
                          color: account.color_3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                " •",
                style: TextStyle(
                  color: account.color_3,
                  fontSize: 15,
                ),
              ),
              Text(
                " •",
                style: TextStyle(
                  color: account.color_3,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      " Until",
                      style: TextStyle(
                        color: account.color_3,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: account.color_3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        widget.snapshot.child('ltime').value.toString(),
                        style: TextStyle(
                          color: account.color_3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class rightside extends StatefulWidget {
  final DataSnapshot snapshot;
  final bool side;
  final ScreenshotController screenshotController;

  const rightside({
    Key? key,
    required this.snapshot,
    required this.side,
    required this.screenshotController,
  }) : super(key: key);

  @override
  State<rightside> createState() => _rightsideState();
}

class _rightsideState extends State<rightside> {
  _shareQrCode(String add, String atime, String ltime) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    widget.screenshotController.capture().then((image) async {
      if (image != null) {
        try {
          String _extratext = "Address- $add\nEntry- $atime\nExit- $ltime";
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          if (imagePath != null) {
            imagePath.writeAsBytes(image);
            Share.shareFiles(
              [imagePath.path],
              text: _extratext,
            );
          }
        } catch (error) {}
      }
    }).catchError((onError) {
      Fluttertoast.showToast(msg: "Something wrong!!");
    });
  }

  _callNumber(String num) async {
    await FlutterPhoneDirectCaller.callNumber(num);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   widget.snapshot.child('sports').value.toString(),
        //   scale: 7,
        // ),
        const SizedBox(
          height: 7,
        ),
        Text(
          "₹${widget.snapshot.child('amount').value}",
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 218, 173, 37),
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          "(Pay At Location)",
          style: TextStyle(
            fontSize: 8,
            color: Color.fromARGB(255, 218, 173, 37),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            _callNumber(widget.snapshot.child('num').value.toString());
          },
          child: Row(
            children: [
              const SizedBox(
                width: 2,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: account.color_3,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: account.color_3,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.phone,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Call",
                style: TextStyle(
                  color: account.color_3,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            MapsLauncher.launchQuery(
                widget.snapshot.child('address').value.toString());
          },
          child: Row(
            children: [
              const SizedBox(
                width: 2,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: account.color_3,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: account.color_3,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.map,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Map",
                style: TextStyle(
                  color: account.color_3,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        !widget.side
            ? InkWell(
                onTap: () {
                  _shareQrCode(
                    widget.snapshot.child('address').value.toString(),
                    widget.snapshot.child('atime').value.toString(),
                    widget.snapshot.child('ltime').value.toString(),
                  );
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: account.color_3,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: account.color_3,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.share,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Share",
                          style: TextStyle(
                            color: account.color_3,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "Qrcode",
                          style: TextStyle(
                            color: account.color_3,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
