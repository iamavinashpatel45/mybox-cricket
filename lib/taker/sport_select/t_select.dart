import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/taker/home.dart';
import 'package:flutter/material.dart';
import '../booking_details.dart';

class t_select extends StatefulWidget {
  @override
  State<t_select> createState() => _t_selectState();
}

class _t_selectState extends State<t_select> {
  Color color = account.color_1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: account.color_3,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Choose Your Sports",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: account.sports_data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    booking_details.sport_type =
                        account.sports_data![index]['id'];
                    booking_details.sportsname =
                        account.sports_data![index]['name'];
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => t_home(
                            setmarker: index + 1,
                          ),
                        ),
                        (route) => false);
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: color,
                          width: booking_details.sport_type ==
                                  account.sports_data![index]['id']
                              ? 3
                              : 0,
                        ),
                      ),
                      child: ListTile(
                        leading:
                            Image.asset(account.sports_data![index]['image']),
                        title: Text(
                          account.sports_data![index]['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // subtitle: Text(
                        //   account.data_vehicle![index]['desc'],
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
