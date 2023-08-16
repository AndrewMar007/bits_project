import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../data/models/audio_model.dart';

class VinylOverlayWidget extends StatefulWidget {
  final String vinylImage;
  final String mainImage;
  final int index;
  final List<AudioModel> audioList;
  const VinylOverlayWidget(
      {super.key,
      required this.index,
      required this.audioList,
      required this.vinylImage,
      required this.mainImage});

  @override
  State<VinylOverlayWidget> createState() => _VinylOverlayWidgetState();
}

class _VinylOverlayWidgetState extends State<VinylOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    double widgetScalling = scaleSmallDevice(context);
    double textScale = textScaleRatio(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 214, 253),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 5),
                child: Container(
                  height: size.height * 0.07 * widgetScalling,
                  width: size.width * 0.14 * widgetScalling,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      // BoxShadow(
                      //   offset: -Offset(7, 7),
                      //   color: const Color.fromARGB(255, 255, 255, 255),
                      //   blurRadius: 10.0,
                      // ),
                      BoxShadow(
                        offset: Offset(7, 7),
                        color: Color.fromARGB(95, 0, 0, 0),
                        blurRadius: 10.0,
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 211, 214, 253),

                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)
                    // ]),
                  ),
                  child: Stack(children: [
                    Container(
                      height: size.height * 0.08 * widgetScalling,
                      width: size.width * 0.24 * widgetScalling,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                            "assets/images/vinyl.png",
                          ))),
                    ),
                    Center(
                      child: Container(
                        height: size.height * 0.02 * widgetScalling,
                        width: size.width * 0.08 * widgetScalling,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${getApiURl()}/${widget.vinylImage}'))),
                      ),
                    )
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                child: Container(
                  height: size.height * 0.07 * widgetScalling,
                  width: size.width * 0.14 * widgetScalling,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        image:
                            NetworkImage('${getApiURl()}/${widget.mainImage}')),
                    boxShadow: [
                      BoxShadow(
                        offset: -const Offset(2, 2),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        blurRadius: 10.0,
                      ),
                      const BoxShadow(
                        offset: Offset(2, 2),
                        color: Color.fromARGB(95, 0, 0, 0),
                        blurRadius: 10.0,
                      ),
                    ],
                    shape: BoxShape.rectangle,
                    color: const Color.fromARGB(255, 211, 214, 253),

                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)
                    // ]),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.audioList[widget.index].login! + "  -",
                textScaleFactor: 1.5 * textScale,
                style: TextStyle(
                    fontFamily: BitsFont.segoeItalicFont, color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.audioList[widget.index].audioName!,
                textScaleFactor: 1.5 * textScale,
                style: TextStyle(
                    fontFamily: BitsFont.segoeItalicFont, color: Colors.black),
              ),
            ],
          ),
          TextButton(
              onPressed: () {},
              child: Icon(
                Icons.play_arrow,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
