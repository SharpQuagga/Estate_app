import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'DetailPage.dart';

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        canvasColor: Colors.transparent,
        fontFamily: "Raleway",
        primarySwatch: Colors.blue,
      ),
      home: new Llist(),
    );
  }
}

class Llist extends StatefulWidget {
  @override
  _LlistState createState() => new _LlistState();
}

class _LlistState extends State<Llist> {
  String _brokerSelectedArea;
  int _grpValue=1;
  var _currentCity='Delhi';

  Future _getDetailsOfLocation() async {
    Firestore fs = Firestore.instance;
    QuerySnapshot qs = await fs.collection("Properties").getDocuments();
    return qs.documents;
  }

  
_navigateToDetail(DocumentSnapshot doc){
  Navigator.push(context, MaterialPageRoute(builder:(context)=>Details(ds: doc)));
}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // leading: new FlatButton(
        //     onPressed: () => {},
        //     child: new Icon(
        //       Icons.menu,
        //       color: Colors.white,
        //     )),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
         child: new ListView(
    children: <Widget>[
      new DrawerHeader(
       child: Center(
          child: new Text("ESTATE APP"),
       ),
        decoration: new BoxDecoration(
            color: Colors.pink
        ),
      ),
      ListTile(
        title: Text("My Account"),
        onTap: (){},
      ),
      ListTile(
        title: Text("Saved Properties"),
        onTap: (){},
      ),
      ListTile(
        title: Text("Search"),
        onTap: (){},
      ),
      ListTile(
        title: Text("About Us"),
        onTap: (){},
      ),
    ],
  )
      ),
      backgroundColor: Colors.white,
      body: new Stack(
        children: [
          new Container(
            child: new Transform.translate(
              offset: new Offset(0.0, -56.0),
              child: new ClipPath(
                clipper: new MyClipper(),
                child: new Stack(
                  children: [
                    new Image.asset(
                      "assets/bu.png",
                      fit: BoxFit.cover,
                    ),
                    new Opacity(
                      opacity: 0.5,
                      child: new Container(color: Colors.blueGrey),
                    ),
                    new Transform.translate(
                      offset: Offset(0.0, 50.0),
                      child: new ListTile(
                        leading: SizedBox(
                          width: 30,
                        ),
                        title: new Text(
                          "Hello Jack",
                          style: new TextStyle(
                              // fontFamily: "Raleway",
                              color: Colors.white,
                              fontSize: 24.0,
                              letterSpacing: 2.0),
                        ),
                        subtitle: new Text(
                          "Raisina Hills,Delhi",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Positioned(
            top: 100.0,
            left: 280.0,
            child: new FloatingActionButton(
              onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return BottomSheetSwitch(
                    ggrpValue: _grpValue,
                    currentCity: _currentCity,
                  );
                },
              );
            },
              backgroundColor: Colors.pinkAccent,
              child: new Icon(Icons.search),
            ),
          ),
          new Transform.translate(
            offset: Offset(0.0, 220.0),
            child: new Column(
              children: <Widget>[],
            ),
          ),
          new Container(
              child: new Column(
            children: <Widget>[
              new Container(height: 140.0),
              new Expanded(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: new Text(
                          "Properties",
                          style: new TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: FutureBuilder(
                        future: _getDetailsOfLocation(),
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),);
                          }else{
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context,index){
                                return makeCard(snapshot.data[index]);
                                // return makeCard(snapshot.data[index].data["Address"],snapshot.data[index].data["Property Type"],
                                // snapshot.data[index].data["Construction Status"],snapshot.data[index].data["Rent"]);
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),)
        ],
      ),
    );
  }

  Card makeCard(DocumentSnapshot snap) { 
  return Card(
  elevation: 8.0,
  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  child: Container(
    height: 100,
    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
    child: makeListTile(snap),
  ),
);
}


ListTile makeListTile(DocumentSnapshot doc){ 
  return ListTile(
    onTap: ()=>_navigateToDetail(doc),
  contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
  leading: Container(
    child: Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 150,
                child: Text(
                 doc.data["Address"] ,
                 // "Raisina Hills,South Block,Delhi",
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Raleway",
                  ),
                )),
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: SizedBox(
              width: 2,
              height: 50,
              child: Center(
                child: Container(
                  color: Colors.white54,
                ),
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Property Type- " +doc.data["Property Type"] ,
              softWrap: true,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Construction- ",
              softWrap: true,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
               doc.data["Construction Status"] ,
              softWrap: true,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Rent- "+doc.data["Rent"].toString() ,
              softWrap: true,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    ),
  ),
);
}

}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 2.85);
    p.lineTo(0.0, size.height / 4.25);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(0.0, size.height / 8.0);
    var CotrolPnt = Offset(size.width / 2, size.height / 8.0 - 90);
    var EndPnt = Offset(size.width, size.height / 8.0);
    p.quadraticBezierTo(CotrolPnt.dx, CotrolPnt.dy, EndPnt.dx, EndPnt.dy);
    p.lineTo(size.width, size.height);
    p.lineTo(0.0, size.height);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}




class BottomSheetSwitch extends StatefulWidget {
  @override
  _BottomSheetSwitchState createState() => _BottomSheetSwitchState();
   final String currentCity;
  final int ggrpValue;
  BottomSheetSwitch({ this.ggrpValue, this.currentCity});
}

class _BottomSheetSwitchState extends State<BottomSheetSwitch> {
   var locations = ['Delhi', 'Ludhiana', 'Gurugram'];
   var type = ['Residential','Commercial','All'];
   var consStatus=['Under Construction','Completed','All'];
   var propStatus=['Finished','Unfinished','SemiFinished'];
   var _currentProp='Finished';
   var _currentStatus='Completed';
   var _currentType = 'Residential';
   var  _currentItem='Delhi';
   int grpValue=1;

   void change(int e){
    setState(() {
     if(e==1){
       grpValue=1;
     } else{grpValue=2;}
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
            clipper: MyClipper2(),
            child: Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                     "Search Options",
                    style: TextStyle(color: Colors.white, fontSize: 27),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 20,),
                      Text("Select City:",style: TextStyle(fontSize: 17,color: Colors.white),),
                      Expanded(
                        child:Container(),
                      ),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white,fontSize: 17),
                        items: locations.map((String dropDowmItem){
                          return DropdownMenuItem<String>(child: Text(dropDowmItem),value: dropDowmItem,);
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                           this._currentItem = newValue; 
                          });
                        },
                        value: _currentItem,  
                      ),
                      SizedBox(width: 30,)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:<Widget>[
                      SizedBox(width:20),
                      Text("Purpose",style: TextStyle(fontSize: 17,color: Colors.white),),
                      ButtonBar(
                        children:<Widget>[
                          Radio(
                            activeColor: Colors.white,
                            groupValue: grpValue,
                             value: 1, 
                             onChanged: (int e) =>change(e),
                          ),
                          Text("Rent",style: TextStyle(fontSize: 17,color: Colors.white),),
                          Radio(
                            activeColor: Colors.white,
                            groupValue: grpValue,
                             value: 2, 
                             onChanged: (int e) =>change(e),
                          ),
                          Text("Sale",style: TextStyle(fontSize: 17,color: Colors.white),),
                        ]
                      )
                    ]
                   ),
                    Row(
                    children:<Widget>[
                      SizedBox(width: 20,),
                      Text("Property Type",style: TextStyle(fontSize: 17,color: Colors.white),),
                     Expanded(
                        child:Container(),
                      ),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white,fontSize: 17),
                        items: type.map((String dropDowmItem){
                          return DropdownMenuItem<String>(child: Text(dropDowmItem),value: dropDowmItem,);
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                           this._currentType = newValue; 
                          });
                        },
                        value: _currentType,  
                      ),
                        SizedBox(width: 30,)
                    ]
                   ),
                   Row(
                    children:<Widget>[
                      SizedBox(width: 20,),
                      Text("Construction Status",style: TextStyle(fontSize: 15,color: Colors.white),),
                     Expanded(
                        child:Container(),
                      ),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white,fontSize: 15),
                        items: consStatus.map((String dropDowmItem){
                          return DropdownMenuItem<String>(child: Text(dropDowmItem),value: dropDowmItem,);
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                           this._currentStatus = newValue; 
                          });
                        },
                        value: _currentStatus,  
                      ),
                        SizedBox(width: 30,)
                    ]
                   ),
                   Row(
                    children:<Widget>[
                      SizedBox(width: 20,),
                      Text("Property Status",style: TextStyle(fontSize: 15,color: Colors.white),),
                     Expanded(
                        child:Container(),
                      ),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white,fontSize: 15),
                        items: propStatus.map((String dropDowmItem){
                          return DropdownMenuItem<String>(child: Text(dropDowmItem),value: dropDowmItem,);
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                           this._currentProp = newValue; 
                          });
                        },
                        value: _currentProp,  
                      ),
                        SizedBox(width: 30,)
                    ]
                   ),
                    ],
              ),
            ),
          );
  }
}
