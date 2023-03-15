import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/taker/booking_details.dart';
import 'package:crave_cricket/taker/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:upi_india/upi_india.dart';

class payment extends StatefulWidget {
  const payment({Key? key}) : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  Color color = HexColor("#155E83");
  bool dis = false;
  bool book = false;
  UpiIndia _upiIndia = UpiIndia();
  Future<UpiResponse>? _transaction;
  int _value = 1;
  bool pay = true;
  Razorpay _razorpay = Razorpay();

  booking() async {
    setState(() {
      book = true;
    });
    bool a = await booking_details.add_data(context);
    if (a) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const t_home(
            setmarker: 1,
          ),
        ),
        (route) => false,
      );
    } else {
      setState(() {
        book = false;
      });
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  var options = {
    'key': 'rzp_test_pX2RUMX7cV11Pz',
    'amount': booking_details.amount!, //in the smallest currency sub-unit.
    'name': 'QuickPark',
    'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': '',
    'timeout': 180, // in seconds
    'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  };

  @override
  void initState() {
    //set_vehicle();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int dur_hou = booking_details.difference!.inHours;
    int dur_min = booking_details.difference!.inMinutes -
        (booking_details.difference!.inHours * 60);
    String a_time = TimeOfDay(
            hour: booking_details.a_time!.hour,
            minute: booking_details.a_time!.minute)
        .format(context);
    String l_time = TimeOfDay(
            hour: booking_details.l_time!.hour,
            minute: booking_details.l_time!.minute)
        .format(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: color,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.place,
                    size: 30,
                  ),
                  Expanded(
                    child: Text(
                      booking_details.address!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Material(
                  elevation: 15,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(color: Colors.black),
                    ),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    booking_details.sportsname!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: color,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Image.asset(
                                    account.sports_data![
                                        booking_details.sport_type]['image'],
                                    scale: 15,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'BASIC PASS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '₹ ${booking_details.amount}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: color,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "ENTRY",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: color,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "${booking_details.a_date!.day}/${booking_details.a_date!.month}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      a_time,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "EXIT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: color,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "${booking_details.l_date!.day}/${booking_details.l_date!.month}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      l_time,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'Duration of your booking: ' +
                      dur_hou.toString() +
                      " hours " +
                      dur_min.toString() +
                      " minutes",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Payment Options::",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                title: Transform.translate(
                  offset: pay ? const Offset(-25, 25) : const Offset(-25, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("UPI Payment"),
                      pay
                          ? Wrap(
                              alignment: WrapAlignment.start,
                              children: booking_details.apps!
                                  .map<Widget>((UpiApp app) {
                                return InkWell(
                                  onTap: () {
                                    try {
                                      _razorpay.open(options);
                                    } catch (e) {}
                                  },
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.memory(
                                          app.icon,
                                          height: 60,
                                          width: 60,
                                        ),
                                        Text(app.name),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : Container()
                    ],
                  ),
                ),
                leading: Transform.translate(
                  offset: const Offset(-15, 0),
                  child: Radio(
                    value: 1,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = 1;
                        pay = true;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: !pay ? 0 : 15,
              ),
              ListTile(
                title: Transform.translate(
                  offset: !pay ? const Offset(-25, 25) : const Offset(-25, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pay at Location(Store)"),
                      !pay
                          ? const SizedBox(
                              height: 15,
                            )
                          : Container(),
                      !pay
                          ? book
                              ? Container(
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
                                    child: SpinKitCircle(
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      booking();
                                    });
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
                                        'Book',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                          : Container()
                    ],
                  ),
                ),
                leading: Transform.translate(
                  offset: const Offset(-15, 0),
                  child: Radio(
                    value: 2,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = 2;
                        pay = false;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
