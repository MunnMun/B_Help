import 'package:flutter/material.dart';

class NeedInterface extends StatefulWidget {
  const NeedInterface({Key? key}) : super(key: key);

  @override
  State<NeedInterface> createState() => _NeedInterfaceState();
}

class _NeedInterfaceState extends State<NeedInterface> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('need blood interface'),
      ),
    );
  }
}
