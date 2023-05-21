import 'package:flutter/material.dart';

class DonateInterface extends StatefulWidget {
  const DonateInterface({Key? key}) : super(key: key);

  @override
  State<DonateInterface> createState() => _DonateInterfaceState();
}

class _DonateInterfaceState extends State<DonateInterface> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            alignment: Alignment.center,
            child: Text('Thank you for registering we have stored the data that you'
                ' have entered in our database. the data you have entered will be visible'
                ' to the person who needs blood and can contact you through our app ',style: TextStyle(
              fontSize: 18.0
            ),),
          ),
        )
      ),
    );
  }
}
