import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'package:firebase_app/map/glob/bottom';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart' as l;

GlobalKey bkey = GlobalKey();

class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          onTap: () {
            bottomSheet(
              context: context,
              initchildSize: .8,
              widget: Sheet(),
            );
          },
          markerId: MarkerId(office.name),
          position: l.LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Office Locations'),
        elevation: 2,
      ),
      body: GoogleMap(
        mapToolbarEnabled: true,
        scrollGesturesEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: l.LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}

class Sheet extends StatefulWidget {
  const Sheet({super.key});

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        //  dragStartBehavior: DragStartBehavior.down,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.drag_handle),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/pic.jpg',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/pic.jpg',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/pic.jpg',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 20,
                    height: 20,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 200,
                  child: ListTile(
                    leading: Column(
                      children: [
                        Text("hh"),
                        Text("jdjd"),
                      ],
                    ),
                    title: Text('data'),
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                // Text('data')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              child: Card(
                child: Text('gffghm'),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Card(
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/pic.jpg',
                        fit: BoxFit.contain,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
