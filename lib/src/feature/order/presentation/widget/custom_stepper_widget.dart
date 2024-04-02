import 'package:fluent_ui/fluent_ui.dart';

class CustomStepperWidget extends StatefulWidget {
  int currentStep = 0;
  AnimationController controller;
  CustomStepperWidget({super.key, required this.currentStep, required this.controller});

  @override
  State<CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              double width = constraints.maxWidth;
              double itemWidth = (width - (40 * 6)) / 5;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                        stops: [0.0, widget.controller.value < 1 ? widget.controller.value : 1, widget.controller.value < 1 ? widget.controller.value : 1, 1],
                      ),
                    ),
                    child: Text('1', style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 60,
                    width: itemWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                          stops: [
                            0.0,
                            widget.controller.value > 1
                                ? widget.controller.value - 1
                                : widget.controller.value > 2
                                    ? 1
                                    : 0,
                            widget.controller.value > 1
                                ? widget.controller.value - 1
                                : widget.controller.value > 2
                                    ? 1
                                    : 0,
                            1
                          ],
                        ),
                      ),
                      width: itemWidth,
                      height: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                        stops: [
                          0.0,
                          widget.controller.value > 2
                              ? widget.controller.value - 2
                              : widget.controller.value > 3
                                  ? 1
                                  : 0,
                          widget.controller.value > 2
                              ? widget.controller.value - 2
                              : widget.controller.value > 3
                                  ? 1
                                  : 0,
                          1
                        ],
                      ),
                    ),
                    child: Text('2', style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 60,
                    width: itemWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                          stops: [
                            0.0,
                            widget.controller.value > 3
                                ? widget.controller.value - 3
                                : widget.controller.value > 4
                                    ? 1
                                    : 0,
                            widget.controller.value > 3
                                ? widget.controller.value - 3
                                : widget.controller.value > 4
                                    ? 1
                                    : 0,
                            1
                          ],
                        ),
                      ),
                      width: itemWidth,
                      height: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                        stops: [
                          0.0,
                          widget.controller.value > 4
                              ? widget.controller.value - 4
                              : widget.controller.value > 5
                                  ? 1
                                  : 0,
                          widget.controller.value > 4
                              ? widget.controller.value - 4
                              : widget.controller.value > 5
                                  ? 1
                                  : 0,
                          1
                        ],
                      ),
                    ),
                    child: Text('3', style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 60,
                    width: itemWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                          stops: [
                            0.0,
                            widget.controller.value > 5
                                ? widget.controller.value - 5
                                : widget.controller.value > 6
                                    ? 1
                                    : 0,
                            widget.controller.value > 5
                                ? widget.controller.value - 5
                                : widget.controller.value > 6
                                    ? 1
                                    : 0,
                            1
                          ],
                        ),
                      ),
                      width: itemWidth,
                      height: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                        stops: [
                          0.0,
                          widget.controller.value > 6
                              ? widget.controller.value - 6
                              : widget.controller.value > 7
                                  ? 1
                                  : 0,
                          widget.controller.value > 6
                              ? widget.controller.value - 6
                              : widget.controller.value > 7
                                  ? 1
                                  : 0,
                          1
                        ],
                      ),
                    ),
                    child: Text('4', style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 60,
                    width: itemWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                          stops: [
                            0.0,
                            widget.controller.value > 7
                                ? widget.controller.value - 7
                                : widget.controller.value > 8
                                    ? 1
                                    : 0,
                            widget.controller.value > 7
                                ? widget.controller.value - 7
                                : widget.controller.value > 8
                                    ? 1
                                    : 0,
                            1
                          ],
                        ),
                      ),
                      width: itemWidth,
                      height: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                        stops: [
                          0.0,
                          widget.controller.value > 8
                              ? widget.controller.value - 8
                              : widget.controller.value > 9
                                  ? 1
                                  : 0,
                          widget.controller.value > 8
                              ? widget.controller.value - 8
                              : widget.controller.value > 9
                                  ? 1
                                  : 0,
                          1
                        ],
                      ),
                    ),
                    child: Text('5', style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 60,
                    width: itemWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                          stops: [
                            0.0,
                            widget.controller.value > 9
                                ? widget.controller.value - 9
                                : widget.controller.value > 10
                                    ? 1
                                    : 0,
                            widget.controller.value > 9
                                ? widget.controller.value - 9
                                : widget.controller.value > 10
                                    ? 1
                                    : 0,
                            1
                          ],
                        ),
                      ),
                      width: itemWidth,
                      height: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green, Colors.grey, Colors.grey],
                        stops: [
                          0.0,
                          widget.controller.value > 10
                              ? widget.controller.value - 10
                              : widget.controller.value > 11
                                  ? 1
                                  : 0,
                          widget.controller.value > 10
                              ? widget.controller.value - 10
                              : widget.controller.value > 11
                                  ? 1
                                  : 0,
                          1
                        ],
                      ),
                    ),
                    child: Icon(FluentIcons.check_mark, color: Colors.white),
                  ),
                ],
              );
            }),
          );
        });
  }
}
