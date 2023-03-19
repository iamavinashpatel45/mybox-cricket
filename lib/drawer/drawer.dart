import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/drawer/allbooking.dart';
import 'package:crave_cricket/giver/g_details.dart';
import 'package:crave_cricket/log_in/choice.dart';
import 'package:crave_cricket/taker/booking_details.dart';
import 'package:crave_cricket/taker/sport_select/t_select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vibration/vibration.dart';
import '../taker/booked/booked.dart';

class drawer extends StatelessWidget {
  final bool type;

  const drawer({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = account.color_1;
    return Drawer(
      backgroundColor: account.color_3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: account.color_1,
                ),
                accountName: Text("${account.fname_!} ${account.lname_!}"),
                accountEmail: Text(account.email_!),
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-KU4nchvUY3YAlh3M2Gp_xF3V6CE1UMbm09uiM6YM&s",width: 50),
                // ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: account.color_1,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: account.color_1,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              !type
                  ? Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.update,
                            color: account.color_1,
                          ),
                          title: Text(
                            "Update Data",
                            style: TextStyle(
                              color: account.color_1,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => g_details(
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  update: true,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.list,
                            color: account.color_1,
                          ),
                          title: Text(
                            "Past Booking",
                            style: TextStyle(
                              color: account.color_1,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const allbooking(
                                  user: false,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.qr_code_scanner,
                            color: account.color_1,
                          ),
                          title: Text(
                            "Scan Qr Code",
                            style: TextStyle(
                              color: account.color_1,
                            ),
                          ),
                          onTap: () async {
                            bool mybox = false;
                            String result =
                                await FlutterBarcodeScanner.scanBarcode(
                              '#ff6666',
                              'Cancel',
                              true,
                              ScanMode.QR,
                            );
                            if (result != '-1') {
                              for (int i = 0; i < account.qr_data.length; i++) {
                                if (account.qr_data[i] == result) {
                                  mybox = true;
                                  break;
                                }
                              }
                              Vibration.vibrate(duration: 500);
                              if (mybox) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  barrierDismissible: false,
                                  confirmBtnColor: color,
                                );
                              } else {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Not Allow',
                                  confirmBtnColor: color,
                                );
                              }
                            }
                          },
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.my_library_books,
                            color: account.color_1,
                          ),
                          title: Text(
                            "My Booking",
                            style: TextStyle(
                              color: account.color_1,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const booked(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.list,
                            color: account.color_1,
                          ),
                          title: Text(
                            "Past Booking",
                            style: TextStyle(
                              color: account.color_1,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const allbooking(
                                  user: true,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.sports,
                            color: account.color_1,
                          ),
                          title: Text(
                            account.sports_data![booking_details.sport_type - 1]
                                ['name'],
                            style: TextStyle(
                              color: account.color_1,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => t_select(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: account.color_1,
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    color: account.color_1,
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const choice(
                        choise: true,
                      ),
                    ),
                    (route) => false,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.contacts,
                  color: account.color_1,
                ),
                title: Text(
                  "Contact Us",
                  style: TextStyle(
                    color: account.color_1,
                  ),
                ),
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
