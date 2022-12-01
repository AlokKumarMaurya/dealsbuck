import 'package:flutter/material.dart';

import '../persistent_tab.dart';

class DealsBuckScreen extends StatefulWidget {
  const DealsBuckScreen({Key? key}) : super(key: key);

  @override
  State<DealsBuckScreen> createState() => _DealsBuckScreenState();
}

class _DealsBuckScreenState extends State<DealsBuckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deals"),),
    );
  }
}
