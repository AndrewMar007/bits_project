import 'package:flutter/material.dart';
import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';

class VinylPlaylistTile extends StatefulWidget {
  final String? mainImage;
  final String? vinylImage;
  final bool? isAnimated;
  final String? vinylName;
  final String? author;
  final Function()? onTap;
  const VinylPlaylistTile(
      {this.onTap,
      this.isAnimated,
      super.key,
      this.author,
      this.vinylName,
      required this.mainImage,
      required this.vinylImage});

  @override
  State<VinylPlaylistTile> createState() => _VinylPlaylistTileState();
}

class _VinylPlaylistTileState extends State<VinylPlaylistTile>
    with TickerProviderStateMixin {
  @override
  void initState() {
    //   if (widget.isAnimated == true) {
    //     print("hello");
    //     _controller.forward();
    //   } else {
    //     _controller.stop();
    //   }
    // });
    // widget.isAnimated = widget.isAnimated;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    // double? textScale = textScaleRatio(context);
    // double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;
    // widget.isAnimated ? _controller.forward() : _controller.stop();
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // SizedBox(
          //   height: size.height * 0.2 * widgetScalling!,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 70.0, top: 13),
          //   child: Container(
          //     height: size.height * 0.10 * widgetScalling!,
          //     width: size.width * 0.2 * widgetScalling,
          //     decoration: const BoxDecoration(
          //       boxShadow: [
          //         // BoxShadow(
          //         //   offset: -Offset(7, 7),
          //         //   color: const Color.fromARGB(255, 255, 255, 255),
          //         //   blurRadius: 10.0,
          //         // ),
          //         BoxShadow(
          //           offset: Offset(7, 7),
          //           color: const Color.fromARGB(95, 0, 0, 0),
          //           blurRadius: 10.0,
          //         ),
          //       ],
          //       shape: BoxShape.circle,
          //       color: Color.fromARGB(255, 211, 214, 253),

          //       // boxShadow: [
          //       //   BoxShadow(
          //       //       color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)
          //       // ]),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: 80, top: size.height * 0.02 * widgetScalling!),
          //   child: Container(
          //     height: size.height * 0.16 * widgetScalling,
          //     width: size.width * 0.33 * widgetScalling,
          //     child: RotationTransition(
          //       turns: _animation,
          //       child: Stack(alignment: Alignment.center, children: [
          //         Container(
          //           height: size.height * 0.15 * widgetScalling,
          //           width: size.width * 0.32 * widgetScalling,
          //           decoration: const BoxDecoration(
          //               shape: BoxShape.circle,
          //               image: DecorationImage(
          //                   fit: BoxFit.cover,
          //                   image: AssetImage(
          //                     "lib/images/vinyl.png",
          //                   ))),
          //         ),
          //         Center(
          //           child: Container(
          //             height: size.height * 0.03 * widgetScalling,
          //             width: size.width * 0.6 * widgetScalling,
          //           ),
          //         )
          //       ]),
          //     ),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(
                right: 0.0, top: size.height * 0.015 * widgetScalling),
            child: Stack(children: [
              SizedBox(
                //color: Colors.black,
                height: size.height * 0.2 * widgetScalling,
                width: size.width * 0.45 * widgetScalling,

                // image: DecorationImage(
                //     fit: BoxFit.cover,
                //     filterQuality: FilterQuality.high,
                //     image: NetworkImage(
                //         'http://192.168.137.1:3000/${widget.mainImage}')),
                // boxShadow: [
                //   BoxShadow(
                //     offset: -Offset(7, 7),
                //     color: const Color.fromARGB(255, 255, 255, 255),
                //     blurRadius: 10.0,
                //   ),
                //   const BoxShadow(
                //     offset: Offset(7, 7),
                //     color: Color.fromARGB(95, 0, 0, 0),
                //     blurRadius: 10.0,
                //   ),
                // ],
                // shape: BoxShape.rectangle,
                // color: const Color.fromARGB(255, 211, 214, 253),

                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)
                // ]),

                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.199 * widgetScalling,
                      width: size.width * 0.45 * widgetScalling,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(4, 4),
                              blurRadius: 5.0)
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            image: NetworkImage(
                                '${getApiURl()}/${widget.mainImage}')),
                      ),
                    ),
                    Container(
                      height: size.height * 0.199 * widgetScalling,
                      width: size.width * 0.45 * widgetScalling,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset('assets/images/noise.png'),
                      ),
                    ),
                    Container(
                      height: size.height * 0.2 * widgetScalling,
                      width: size.width * 0.45 * widgetScalling,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromARGB(127, 0, 0, 0),
                            Color.fromARGB(36, 0, 0, 0),
                            Color(0x00000000),
                            Color.fromARGB(92, 0, 0, 0),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01 * widgetScalling,
                        left: size.height * 0.17 * widgetScalling,
                      ),
                      child: const Icon(
                        Icons.play_circle_outline_outlined,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Color.fromARGB(118, 0, 0, 0),
                              offset: Offset(2, 2),
                              blurRadius: 1.0)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       top: size.height * 0.145 * widgetScalling,
          //       left: size.width * 0.02 * widgetScalling,
          //       right: size.width * 0.02 * widgetScalling),
          //   child: Divider(
          //     thickness: 1.5,
          //     color: Colors.white,
          //     height: size.height * 0.04 * widgetScalling,
          //   ),
          // ),

          // Image.file(
          //   height: size.height * 0.27 * widgetScalling,
          //   width: size.width * 0.54 * widgetScalling,
          //   widget.mainImage,
          //   fit: BoxFit.cover,
          // ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05 * widgetScalling,
                  left: size.width * 0.25 * widgetScalling,
                ),
                child: Container(
                  height: size.height * 0.31 * widgetScalling,
                  width: size.width * 0.31 * widgetScalling,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                        "assets/images/vinyl.png",
                      ))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.106 * widgetScalling,
                  left: size.width * 0.36 * widgetScalling,
                ),
                child: Container(
                  height: size.height * 0.09 * widgetScalling,
                  width: size.width * 0.09 * widgetScalling,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        image:
                            NetworkImage('${getApiURl()}/${widget.mainImage}')),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.08 * widgetScalling,
                  top: size.height * 0.16 * widgetScalling,
                ),
                child: Text(
                  widget.author!,
                  textAlign: TextAlign.center,
                  textScaleFactor: 0.8 * widgetScalling,
                  style: const TextStyle(shadows: [
                    Shadow(
                        color: Color.fromARGB(110, 0, 0, 0),
                        offset: Offset(2, 2),
                        blurRadius: 0.5)
                  ], fontFamily: BitsFont.spaceMono, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.08 * widgetScalling,
                  top: size.height * 0.18 * widgetScalling,
                ),
                child: Text(
                  widget.vinylName!,
                  textAlign: TextAlign.center,
                  textScaleFactor: 0.8 * widgetScalling,
                  style: const TextStyle(shadows: [
                    Shadow(
                        color: Color.fromARGB(110, 0, 0, 0),
                        offset: Offset(2, 2),
                        blurRadius: 0.5)
                  ], fontFamily: BitsFont.spaceMono, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
