import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();

   final DocumentSnapshot doc;
  MapView({this.doc});
}

class _MapViewState extends State<MapView> {
  GoogleMapController googleMapController;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 500,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: (controller){
                    setState(() {
                     googleMapController=controller; 
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.doc.data["Location"].latitude, widget.doc.data["Location"].longitude),
                    zoom: 20.0,
                  ),),
              ),
              SizedBox(height: 10,),
              FlatButton(
                color: Colors.transparent,
                onPressed: googleMapController == null ? null :(){
                  googleMapController.addMarker(
                    MarkerOptions(
                      draggable: false,
                      position: LatLng(30.8932, 75.8233),
                      infoWindowText: InfoWindowText("Location", "Marker Dropped"),
                    )
                  );
                },
                child: Text("Add Marker",style: TextStyle(fontSize: 20,color: Colors.blue),),
              )
          ],
        ),
      ),
    );
  }
}