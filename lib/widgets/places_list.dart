// tasks.dart

import 'package:flutter/material.dart';
import '../utils/points_counter.dart';
import 'package:provider/provider.dart';
import '../utils/location_function.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';

bool globalresumed = false;
bool globalstarted = true;
List<bool> globalinitialvalues = [false,false,false,false];

Color checkboxColor = Colors.white;


class Place {
  String name;
  bool isCompleted;
  String imageAsset;
  final Tuple2<double, double> location; // Renamed from image_asset to follow Dart conventions

  Place({
    required this.name,
    required this.imageAsset,
    required this.isCompleted,
    required this.location,

  });
}class PlacesList extends StatefulWidget {
  final List<Place> places;
  final Function()? infoCallback;
  final String userId;

  PlacesList({
    required this.places,
    this.infoCallback,
    required this.userId,
  });

  @override
  _PlacesListState createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  bool resumed = globalresumed;
  bool started = globalstarted;
  late Position alpha;
  List<bool> initialvalues = globalinitialvalues;

  @override
  Widget build(BuildContext context) {
    var points = Provider.of<PointsCounter>(context);
    if(started){
      started = false;
      globalstarted = false;
      points.pauseTimer();
    }
    for(int i = 0 ; i < widget.places.length; i++){
      widget.places[i].isCompleted = initialvalues[i];
    }

    return Column(
      children: [
        for (int index = 0; index < widget.places.length; index++)
          Container(
            child: Row(
              children: [
                Container(
                  width: 300, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.places[index].imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Checkbox(
                  value: widget.places[index].isCompleted,
                  activeColor: checkboxColor,
                  onChanged: (bool? newValue) async {
                    // Handle checkbox value change
                    Position cur_location = await LocationHelper.getLocation();
                    setState(() {
                      globalinitialvalues[index] = newValue ?? false;
                      widget.places[index].isCompleted = newValue ?? false;
                      resumed = false;
                      int counter = 0;
                      int index_checked = 0;
                      for(int i = 0 ; i < widget.places.length; i++){
                        if(widget.places[i].isCompleted){
                          resumed = true;
                          counter++;
                          index_checked = i;
                        }
                      }
                      if(resumed && counter ==1){
                        // if (cur_location.latitude.toInt() == widget.places[index_checked].location.item1 && 
                        //   cur_location.longitude.toInt() == widget.places[index_checked].location.item2){
                          
                        if (double.parse(cur_location.latitude.toStringAsFixed(5)) == widget.places[index_checked].location.item1 && 
                          double.parse(cur_location.longitude.toStringAsFixed(5))== widget.places[index_checked].location.item2){
                            checkboxColor = Colors.green;
                            points.resumeTimer();
                          }
                      }else{
                        checkboxColor = Colors.white;
                        points.pauseTimer();
                      }
                      // Update the isCompleted property when the checkbox is pressed
                    });
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
