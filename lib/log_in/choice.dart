import 'package:crave_cricket/account/account.dart';
import 'package:crave_cricket/log_in/sign_up.dart';
import 'package:flutter/material.dart';
import 'log_in.dart';

class choice extends StatefulWidget {
  final bool choise;

  const choice({Key? key, required this.choise}) : super(key: key);

  @override
  State<choice> createState() => _choiceState();
}

class _choiceState extends State<choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: account.color_3,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: account.color_3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: widget.choise == true ? 115 : 95,
            ),
            Hero(
              tag: "logo",
              child: Image.asset(
                'assets/logo__.png',
                scale: 2.2,
              ),
            ),
            SizedBox(
              height: widget.choise == true ? 0 : 20,
            ),
            widget.choise == false
                ? Text(
                    "Thank you for Joining with Us",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: account.color_1,
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "You need to log in or create an account to continue.",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: account.color_1,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => log_in(
                      choise: widget.choise,
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: account.color_1,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Center(
                    child: Text(
                  "Log in with email",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: account.color_3,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => sign_up(
                      choise: widget.choise,
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: account.color_1,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Center(
                    child: Text(
                  "Create account with email",
                  style: TextStyle(
                    color: account.color_3,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                )),
              ),
            ),
            SizedBox(
              height: widget.choise == true ? 50 : 100,
            ),
            widget.choise == true
                ? SizedBox(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => const choice(
                                  choise: false,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/join.png',
                                  scale: 1,
                                  color: account.color_1,
                                ),
                                Text(
                                  "Join With Us",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: account.color_1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
