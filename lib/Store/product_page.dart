import 'package:flora_app/Widgets/customAppBar.dart';
import 'package:flora_app/Widgets/myDrawer.dart';
import 'package:flora_app/Models/item.dart';
import 'package:flutter/material.dart';
import 'package:flora_app/Store/storehome.dart';


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(
      ),
    );
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
