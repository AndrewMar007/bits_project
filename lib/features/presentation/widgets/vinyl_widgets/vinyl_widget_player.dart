import 'package:bits_project/core/values/config.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/device_platform_scale.dart';

class VinylAudioPlayerWidget extends StatefulWidget {
  String mainImage;
  String vinylImage;
  bool? isAnimated;
  Function()? onTap;
  VinylAudioPlayerWidget(
      {this.onTap,
      this.isAnimated,
      super.key,
      required this.mainImage,
      required this.vinylImage});

  @override
  State<VinylAudioPlayerWidget> createState() => _VinylAudioPlayerWidgetState();
}

class _VinylAudioPlayerWidgetState extends State<VinylAudioPlayerWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );
  @override
  void initState() {
    print(widget.isAnimated);

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
    Size size = MediaQuery.of(context).size;
    if (widget.isAnimated == true) {
      _controller.repeat();
      if (_controller.isCompleted) {
        _controller.repeat();
      }
    } else {
      _controller.stop();
    }
    // widget.isAnimated ? _controller.forward() : _controller.stop();
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 120.0, top: 50),
            child: Container(
              height: size.height * 0.16 * widgetScalling!,
              width: size.width * 0.36 * widgetScalling,
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
              child: RotationTransition(
                turns: _animation,
                child: Stack(children: [
                  Container(
                    height: size.height * 0.36 * widgetScalling,
                    width: size.width * 0.36 * widgetScalling,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                          "assets/images/vinyl.png",
                        ))),
                  ),
                  Center(
                    child: Container(
                      height: size.height * 0.05 * widgetScalling,
                      width: size.width * 0.13 * widgetScalling,
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0, top: 20.0),
            child: Container(
              height: size.height * 0.22 * widgetScalling,
              width: size.width * 0.44 * widgetScalling,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    image: NetworkImage('${getApiURl()}/${widget.mainImage}')),
                boxShadow: [
                  BoxShadow(
                    offset: -const Offset(7, 7),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    blurRadius: 10.0,
                  ),
                  const BoxShadow(
                    offset: Offset(7, 7),
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
          // Image.file(
          //   height: size.height * 0.27 * widgetScalling,
          //   width: size.width * 0.54 * widgetScalling,
          //   widget.mainImage,
          //   fit: BoxFit.cover,
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }
}
