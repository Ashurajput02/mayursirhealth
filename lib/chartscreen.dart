// import 'dart:async';
// import 'package:biomedicalfinal/bluetoothscreen.dart';
// import 'package:biomedicalfinal/db/database.dart';
// import 'package:biomedicalfinal/sync_chart.dart';
// import 'package:flutter/material.dart';
// import 'screenfour.dart';
// // Import the Bluetooth class

// class ChartScreen extends StatefulWidget {
//   late String name, id, age, sex, visitno, weight, weightattached;
//   ChartScreen(this.name, this.id, this.age, this.sex, this.visitno, this.weight,
//       this.weightattached,
//       {Key? key})
//       : super(key: key);

//   @override
//   _ChartScreenState createState() => _ChartScreenState();
// }

// class _ChartScreenState extends State<ChartScreen> {
//   late String name, id, age, sex, visitno, weight, weightattached;
//   late bool receiving;
//   late double area;
//   late List<double> chartData;
//   late StreamSubscription<double> _streamSubscription;

//   @override
//   void initState() {
//     super.initState();
//     receiving = true;
//     area = 0;
//     chartData = [];

//     // Start listening to the Bluetooth data stream
//     _streamSubscription = Bluetooth.dataStream.listen((data) {
//       if (Bluetooth.receiving) {
//         setState(() {
//           chartData.add(data);
//           if (chartData.length >= 2 && data > chartData[chartData.length - 2]) {
//             area += data;
//           }
//         });
//         print("Received data: $data");
//         print("Chart data updated: $chartData");
//         print('Area: $area');
//       }
//     });

//     // Call the function to start listening and updating the chart
//     // startListeningAndUpdateChart();
//   }

//   @override
//   void dispose() {
//     // Cancel the stream subscription when the widget is disposed
//     _streamSubscription.cancel();
//     Bluetooth.stopBluetooth();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(receiving ? "Recording..." : "Recorded"),
//       ),
//       body: Container(
//         child: Center(
//           child: Column(
//             children: [
//               const SizedBox(height: 80),
//               const Divider(
//                 height: 40, // Adjust the height of the divider as needed
//                 thickness: 2, // Adjust the thickness of the divider as needed
//                 color: Colors.black,
//               ),
//               Center(
//                 child: Visibility(
//                   visible: true,
//                   // child: Chart(
//                   //   chartData: chartData,
//                   // ),
//                   child: SyncChart(data: chartData),
//                 ),
//               ),
//               const Divider(
//                 height: 40, // Adjust the height of the divider as needed
//                 thickness: 2, // Adjust the thickness of the divider as needed
//                 color: Colors.black,
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: SizedBox(
//                   width: 320,
//                   height: 76,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       fixedSize: const Size.fromHeight(60.0),
//                       shape: const StadiumBorder(),
//                       backgroundColor: Colors.red,
//                     ),
//                     child: const Align(
//                         alignment: Alignment.center, child: Text('STOP')),
//                     onPressed: () async {
//                       print("Stop Button Pressed");
//                       // Bluetooth.stopBluetooth();
//                       setState(() {
//                         Bluetooth.receiving = false;
//                       });

//                       String username = widget.name;
//                       String id = widget.id;
//                       String age = widget.age;
//                       String sex = widget.sex;
//                       String visit = widget.visitno;
//                       String weight = widget.weight;
//                       String weightattached = widget.weightattached;
//                       double wd =
//                           (area * (double.parse(weightattached)) * 0.098);
//                       await DatabaseHelper().insertUserData(
//                         username: username,
//                         age: age,
//                         gender: sex,
//                         visit: visit,
//                         area: area.toString(),
//                         id: id,
//                         weight: weight.toString(),
//                         weightattached: weightattached.toString(),
//                         wd: wd.toString(),
//                         samples: chartData,
//                       );
//                       print("Chart data: $chartData");
//                       print("Work Done: $wd");
//                       setState(() {
//                         receiving = false;
//                         chartData.clear();
//                         Bluetooth.receivedDataList.clear();
//                         Bluetooth.receivedDataList.add(0);
//                       });
//                       print("Data saved successfully");
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return screenfour();
//                       }));
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void startListeningAndUpdateChart() {
//     Future<void> updateChart() async {
//       while (receiving) {
//         await Future.delayed(const Duration(milliseconds: 1000));
//       }
//     }

//     updateChart();
//   }
// }

import 'dart:async';
import 'package:biomedicalfinal/bluetoothscreen.dart';
import 'package:biomedicalfinal/db/database.dart';
import 'package:biomedicalfinal/sync_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'screenfour.dart';

class ChartScreen extends StatefulWidget {
  late String name, id, age, sex, visitno, weight, weightattached;
  ChartScreen(this.name, this.id, this.age, this.sex, this.visitno, this.weight,
      this.weightattached,
      {Key? key})
      : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late String name, id, age, sex, visitno, weight, weightattached;
  late bool receiving;
  late double area;
  late List<double> chartData;
  late StreamSubscription<double> _streamSubscription;

  @override
  void initState() {
    super.initState();
    receiving = true;
    area = 0;
    chartData = [];

    // Start listening to the Bluetooth data stream
    _streamSubscription = Bluetooth.dataStream.listen((data) {
      if (Bluetooth.receiving) {
        setState(() {
          chartData.add(data);
          if (chartData.length >= 2 && data > chartData[chartData.length - 2]) {
            area += data;
          }
        });
        print("Received data: $data");
        print("Chart data updated: $chartData");
        print('Area: $area');
      }
    });
  }

  @override
  void dispose() {
    // Cancel the stream subscription when the widget is disposed
    _streamSubscription.cancel();
    Bluetooth.stopBluetooth();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiving ? "Recording..." : "Recorded"),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          // Calculate dynamic dimensions based on the screen type
          double padding = sizingInformation.isTablet ? 20.0 : 10.0;
          double buttonHeight = sizingInformation.isTablet ? 90.0 : 60.0;
          double buttonWidth = sizingInformation.isTablet ? 400.0 : 320.0;
          double chartHeight = sizingInformation.isTablet ? 400.0 : 250.0;
          double dividerThickness = sizingInformation.isTablet ? 3.0 : 2.0;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Divider(
                    height: 40, // Adjust the height of the divider as needed
                    thickness: dividerThickness, // Adjust thickness
                    color: Colors.black,
                  ),
                  Center(
                    child: Visibility(
                      visible: true,
                      child: SizedBox(
                        height: chartHeight,
                        child: SyncChart(data: chartData),
                      ),
                    ),
                  ),
                  Divider(
                    height: 40,
                    thickness: dividerThickness,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, buttonHeight),
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.red,
                      ),
                      child: const Align(
                          alignment: Alignment.center, child: Text('STOP')),
                      onPressed: () async {
                        print("Stop Button Pressed");
                        setState(() {
                          Bluetooth.receiving = false;
                        });

                        String username = widget.name;
                        String id = widget.id;
                        String age = widget.age;
                        String sex = widget.sex;
                        String visit = widget.visitno;
                        String weight = widget.weight;
                        String weightattached = widget.weightattached;
                        double wd =
                            (area * (double.parse(weightattached)) * 0.098);
                        await DatabaseHelper().insertUserData(
                          username: username,
                          age: age,
                          gender: sex,
                          visit: visit,
                          area: area.toString(),
                          id: id,
                          weight: weight.toString(),
                          weightattached: weightattached.toString(),
                          wd: wd.toString(),
                          samples: chartData,
                        );
                        print("Chart data: $chartData");
                        print("Work Done: $wd");
                        setState(() {
                          receiving = false;
                          chartData.clear();
                          Bluetooth.receivedDataList.clear();
                          Bluetooth.receivedDataList.add(0);
                        });
                        print("Data saved successfully");
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return screenfour();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void startListeningAndUpdateChart() {
    Future<void> updateChart() async {
      while (receiving) {
        await Future.delayed(const Duration(milliseconds: 1000));
      }
    }

    updateChart();
  }
}
