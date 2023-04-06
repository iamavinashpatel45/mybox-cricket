import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/taker/booking_details.dart';
import 'package:crave_cricket/taker/datetime_picker/datetime_picker_leave.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class datetime_picker_arrive extends StatefulWidget {
  const datetime_picker_arrive({Key? key}) : super(key: key);

  @override
  State<datetime_picker_arrive> createState() => _datetime_picker_arriveState();
}

class _datetime_picker_arriveState extends State<datetime_picker_arrive> {
  DateTime datetime = DateTime.now();
  Color color = account.color_1;
  var data = [];

  Future<bool> checkslot(DateTime time) async {
    for (int i = 0; i < data.length; i++) {
      if ((time.isAfter(
                DateTime.parse(
                  data[i].first.arrive,
                ),
              ) ||
              time.isAtSameMomentAs(
                DateTime.parse(
                  data[i].first.arrive,
                ),
              )) &&
          time.isBefore(
            DateTime.parse(
              data[i].first.leave,
            ),
          )) {
        Fluttertoast.showToast(msg: "This time allready selected!");
        return false;
      }
    }
    return true;
  }

  fun() async {
    var res = await FirebaseFirestore.instance
        .collection('bookslots')
        .doc(booking_details.marker!.markerId.value.toString())
        .collection(booking_details.sportsname!)
        .get();
    data = res.docs
        .map((e) => {
              getbookslots.fromJson(e.data()),
            })
        .toList();
  }

  @override
  void initState() {
    fun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
            child: Row(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 20) / 2,
                  child: Text(
                    booking_details.address!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: account.color_3,
                    ),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 20) / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        booking_details.sportsname!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: account.color_3,
                        ),
                      ),
                      Image.asset(
                        account.sports_data![booking_details.sport_type - 1]
                            ['image'],
                        scale: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 380,
        decoration: BoxDecoration(
          color: account.color_3,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "When Do You want to arrive?",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: color,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DateTimePicker(
              type: DateTimePickerType.Both,
              startDate: datetime,
              endDate: datetime.add(const Duration(days: 14)),
              startTime: datetime,
              timeInterval: const Duration(minutes: 30),
              onTimeChanged: (time) async {
                await checkslot(time);
                booking_details.a_time = time;
              },
              onDateChanged: (date) async {
                await checkslot(date);
                booking_details.a_date = date;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 20,
                        color: color,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (await checkslot(booking_details.a_time!)) {
                        booking_details.l_time = booking_details.a_time!.add(
                          const Duration(
                            minutes: 30,
                          ),
                        );
                        Navigator.push(
                          context,
                          PageTransition(
                            alignment: Alignment.centerLeft,
                            child: const datetime_picker_leave(),
                            type: PageTransitionType.size,
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 120,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
