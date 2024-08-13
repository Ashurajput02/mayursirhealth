// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class splashscreenfinal extends StatefulWidget{
//   @override
//   State<splashscreenfinal> createState() => _splashscreenfinalState();
// }

// class _splashscreenfinalState extends State<splashscreenfinal> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 5), () {
//       Navigator.of(context).pushReplacementNamed('/screentwo');
//     });
//   }
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body:Container(
//         color: Colors.white,
//         child: Align(
//           alignment:Alignment.center,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 138,
//               ),
//               Image.asset("assets/images/iiitn2.webp",width: 233,height: 186,),
//               SizedBox(
//                 height:18,
//               ),
//               Text("In Collaboration with",style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize:24,
//               ),),
//               SizedBox(
//                 height:18 ,
//               ),
//               Image.asset("assets/images/aiimsfinal.png",width: 233,height: 186,),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SplashScreenFinal extends StatefulWidget {
  @override
  State<SplashScreenFinal> createState() => _SplashScreenFinalState();
}

class _SplashScreenFinalState extends State<SplashScreenFinal> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/screentwo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double imageWidth = getValueForScreenType<double>(
            context: context,
            mobile: MediaQuery.of(context).size.width * 0.6,
            tablet: MediaQuery.of(context).size.width * 0.4,
            desktop: MediaQuery.of(context).size.width * 0.3,
          );

          double textFontSize = getValueForScreenType<double>(
            context: context,
            mobile: 18,
            tablet: 24,
            desktop: 28,
          );

          double verticalSpacing = getValueForScreenType<double>(
            context: context,
            mobile: 12,
            tablet: 18,
            desktop: 24,
          );

          return Container(
            color: Colors.white,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sizingInformation.deviceScreenType ==
                            DeviceScreenType.mobile
                        ? 100
                        : 138,
                  ),
                  Image.asset(
                    "assets/images/iiitn2.webp",
                    width: imageWidth,
                    height: imageWidth * 0.8,
                  ),
                  SizedBox(
                    height: verticalSpacing,
                  ),
                  Text(
                    "In Collaboration with",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textFontSize,
                    ),
                  ),
                  SizedBox(
                    height: verticalSpacing,
                  ),
                  Image.asset(
                    "assets/images/aiimsfinal.png",
                    width: imageWidth,
                    height: imageWidth * 0.8,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
