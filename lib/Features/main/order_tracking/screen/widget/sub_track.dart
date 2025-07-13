import 'package:flutter/material.dart';

class StepTracker extends StatefulWidget {
  const StepTracker({
    super.key,
    required this.title,
    this.icon,
    required this.isLast,
  });

  final String title;
  final bool isLast;
  final IconData? icon;

  @override
  _StepTrackerState createState() => _StepTrackerState();
}

class _StepTrackerState extends State<StepTracker> {
  @override
  Widget build(BuildContext context) {
    Color secondaryVariant = const Color(
      0xFF6C757D,
    ); // Replace with your preferred color
    Color primaryColor = const Color(
      0xFF4C1FA2,
    ); // Replace with your preferred color
    Color whiteColor = const Color(0xFFFFFFFF); // White color

    return Container(
      padding: const EdgeInsetsDirectional.only(top: 4.5, end: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 4.5),
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.square(13),
                        child: Container(color: secondaryVariant),
                      ),
                    ),
                    if (widget.isLast)
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.square(7),
                          child: Container(color: whiteColor),
                        ),
                      ),
                  ],
                ),
              ),
              if (!widget.isLast)
                SizedBox(
                  width: 1,
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => Column(
                          children: [
                            if (index != 4 && index != 0)
                              const SizedBox(height: 5),
                            Container(
                              height:
                                  (MediaQuery.of(context).size.height *
                                      (2.2 / 100)) /
                                  3,
                              width: 3,
                              color: primaryColor,
                            ),
                          ],
                        ),
                  ),
                ),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width * (1.2 / 100)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  strutStyle: const StrutStyle(
                    fontSize: 9.3 * 1.5,
                    height: 1,
                    fontWeight: FontWeight.bold,
                    leading: 0,
                    forceStrutHeight: true,
                  ),
                  style: TextStyle(
                    fontSize: 9.3 * 1.5,
                    height: 1.5,
                    color: secondaryVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 9),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
