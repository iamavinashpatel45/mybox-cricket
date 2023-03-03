import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/sliderimages.dart';
import 'package:crave_cricket/taker/booking_details.dart';
import 'package:crave_cricket/taker/datetime_picker/datetime_picker_leave.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class datetime_picker_arrive extends StatefulWidget {
  const datetime_picker_arrive({Key? key}) : super(key: key);

  @override
  State<datetime_picker_arrive> createState() => _datetime_picker_arriveState();
}

class _datetime_picker_arriveState extends State<datetime_picker_arrive> {
  DateTime datetime = DateTime.now();
  Color color = HexColor("#155E83");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 30, top: 75),
          //   child: sliderimages(
          //     images: account.v[booking_details.marker!.index!][2],
          //     type: false,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                booking_details.address!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 375,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "When Do You want to arrive?",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            DateTimePicker(
              type: DateTimePickerType.Both,
              startDate: datetime,
              endDate: datetime.add(const Duration(days: 7)),
              startTime: datetime,
              timeInterval: const Duration(minutes: 30),
              onTimeChanged: (time) {
                booking_details.a_time = time;
              },
              onDateChanged: (date) {
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
                    onTap: () {
                      booking_details.l_time = booking_details.a_time!
                          .add(const Duration(minutes: 30));
                      Navigator.push(
                          context,
                          PageTransition(
                            alignment: Alignment.centerLeft,
                            child: const datetime_picker_leave(),
                            type: PageTransitionType.size,
                            duration: const Duration(milliseconds: 500),
                          ));
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
                          )),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
