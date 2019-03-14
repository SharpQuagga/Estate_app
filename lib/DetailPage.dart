import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'maps.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();

  final DocumentSnapshot ds;
  Details({this.ds});
}

class _DetailsState extends State<Details> {

  _launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       //  appBar: AppBar(title: const Text('Bottom App Bar')),
    floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.call), onPressed: () {
          _launchURL();
      },),
    bottomNavigationBar: BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {},),
          IconButton(icon: Icon(Icons.map), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MapView(doc: widget.ds,)));
          },),
        ],
      ),
    ),

    body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Material(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    elevation: 10,
                    color: Colors.white54,
                    shadowColor: Colors.pinkAccent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(image: NetworkImage(widget.ds.data["PhotoUrl"]),
                      // image: DecorationImage(image: AssetImage('assets/bu.png'),
                        fit: BoxFit.fill), 
                      ),
                    )
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Property Details",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        _makeRow("Landlord Name",widget.ds.data["Landlord Name"]),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                           _makeRow("Address",widget.ds.data["Address"]),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                           _makeRow("Rent",widget.ds.data["Rent"].toString()),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                           _makeRow("Property Type",widget.ds.data["Property Type"]),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                           _makeRow("Bedrooms ",widget.ds.data["Bedrooms"].toString()),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                          _makeRow("Construction Status",widget.ds.data["Construction Status"]),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                          _makeRow("Property Status",widget.ds.data["Property Status"]),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                          _makeRow("Amenities",widget.ds.data["Amenities"]),
                        SizedBox(height: 4,),
                         SizedBox(height: 2,child: Center(child: Container(color: Colors.black12),),),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
    ),
      ),
    );
  }

Row _makeRow(String txt,String detail){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
   Text(txt,style: TextStyle(color: Colors.black54,fontSize: 16),),
   Container(
     width: 130,
     child: Text(detail,softWrap: true,style: TextStyle(fontSize: 16),)),
      ],
   );
}

}
