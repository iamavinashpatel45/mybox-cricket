import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_cricket/account/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ticket_material/ticket_material.dart';

class allbooking extends StatefulWidget {
  final bool user;
  const allbooking({super.key, required this.user});

  @override
  State<allbooking> createState() => _allbookingState();
}

class _allbookingState extends State<allbooking> {
  Color color = account.color_1;
  bool load = true;
  List data = [];

  _callNumber(String num) async {
    await FlutterPhoneDirectCaller.callNumber(num);
  }

  fun() async {
    if (widget.user) {
      var res = await FirebaseFirestore.instance
          .collection('userdata(allbooking)')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .get();
      data = res.docs
          .map((e) => {
                all_booking.fromJson(e.data()),
              })
          .toList();
      setState(() {
        load = false;
      });
    } else {
      var res = await FirebaseFirestore.instance
          .collection('user_data(allbooking)')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .get();
      data = res.docs
          .map((e) => {
                all_booking.fromJson(e.data()),
              })
          .toList();
      setState(() {
        load = false;
      });
    }
  }

  @override
  void initState() {
    fun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: account.color_3,
      appBar: AppBar(
        title: const Text('Past Booking'),
        backgroundColor: color,
        elevation: 0,
      ),
      body: load
          ? Center(
              child: SpinKitCubeGrid(
                color: account.color_1,
                size: 50.0,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  var x = data[index].first;
                  return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TicketMaterial(
                      height: 220,
                      radiusCircle: 6,
                      leftChild: Column(
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
                                    x.address,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        x.sports,
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
                                          x.atime,
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
                                          x.ltime,
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
                      ),
                      rightChild: Column(
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
                            "₹${x.amount}",
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
                              _callNumber(x.num);
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
                          widget.user
                              ? InkWell(
                                  onTap: () {
                                    MapsLauncher.launchQuery(x.address);
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
                                )
                              : Container()
                        ],
                      ),
                      colorBackground: color,
                    ),
                  );
                }),
              ),
            ),
    );
  }
}

class all_booking {
  String? tId;
  String? gId;
  String? sports;
  String? address;
  String? num;
  String? atime;
  String? ltime;
  String? random;
  String? arrive;
  String? leave;
  String? amount;

  all_booking(
      {this.tId,
      this.gId,
      this.sports,
      this.address,
      this.num,
      this.atime,
      this.ltime,
      this.random,
      this.arrive,
      this.leave,
      this.amount});

  all_booking.fromJson(Map<String, dynamic> json) {
    tId = json['t_id'];
    gId = json['g_id'];
    sports = json['sports'];
    address = json['address'];
    num = json['num'];
    atime = json['atime'];
    ltime = json['ltime'];
    random = json['random'];
    arrive = json['arrive'];
    leave = json['leave'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t_id'] = this.tId;
    data['g_id'] = this.gId;
    data['sports'] = this.sports;
    data['address'] = this.address;
    data['num'] = this.num;
    data['atime'] = this.atime;
    data['ltime'] = this.ltime;
    data['random'] = this.random;
    data['arrive'] = this.arrive;
    data['leave'] = this.leave;
    data['amount'] = this.amount;
    return data;
  }
}
