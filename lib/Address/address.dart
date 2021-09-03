import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora_app/Config/config.dart';
import 'package:flora_app/Orders//placeOrder.dart';
import 'package:flora_app/Widgets/customAppBar.dart';
import 'package:flora_app/Widgets/loadingWidget.dart';
import 'package:flora_app/Widgets/wideButton.dart';
import 'package:flora_app/Models//address.dart';
import 'package:flora_app/Counters/changeAddresss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addAddress.dart';

class Address extends StatefulWidget
{
  @override
  _AddressState createState() => _AddressState();
}


 class _AddressState extends State<Address>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(),
    );
  }

  noAddressCard() {
    return Card(

    );
  }
}

class AddressCard extends StatefulWidget {

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {

    return InkWell(

    );
  }
}





class KeyText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}


