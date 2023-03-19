import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ticket_material/ticket_material.dart';

class g_home extends StatefulWidget {
  const g_home({Key? key}) : super(key: key);

  @override
  State<g_home> createState() => _g_homeState();
}

class _g_homeState extends State<g_home> {
  Color color = account.color_1;
  bool go = true;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference db = FirebaseDatabase.instance
      .ref("booking/${FirebaseAuth.instance.currentUser!.uid}");

  _callNumber(String num) async {
    await FlutterPhoneDirectCaller.callNumber(num);
  }

  delete_data(String key) async {
    DatabaseReference db_delete = FirebaseDatabase.instance
        .ref("booking/${FirebaseAuth.instance.currentUser!.uid}/$key");
    await db_delete.remove().then((value) => () {
          go = false;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const drawer(
        type: false,
      ),
      appBar: AppBar(
        title: const Text('booking'),
        backgroundColor: color,
        elevation: 0,
      ),
      body: FirebaseAnimatedList(
        shrinkWrap: true,
        query: db,
        defaultChild: Center(
          child: SpinKitCubeGrid(
            color: color,
            size: 50.0,
          ),
        ),
        itemBuilder: (context, snapshot, animation, index) {
          go = true;
          account.qr_data.add(snapshot.child('random').value.toString());
          DateTime.now().isBefore(
                  DateTime.parse(snapshot.child('leave').value.toString()))
              ? () {}
              : delete_data(snapshot.key!);
          return go
              ? Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 200,
                    child: TicketMaterial(
                      height: 200,
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
                                    snapshot.child('sports').value.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
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
                                Text(
                                  'BASIC PASS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: account.color_3,
                                    fontSize: 15,
                                  ),
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
                                          snapshot
                                              .child('atime')
                                              .value
                                              .toString(),
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
                                          snapshot
                                              .child('ltime')
                                              .value
                                              .toString(),
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
                            "₹${snapshot.child('amount').value}",
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
                              _callNumber(
                                  snapshot.child('num').value.toString());
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
                        ],
                      ),
                      colorBackground: color,
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
