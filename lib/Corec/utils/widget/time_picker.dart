import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import '../../../corec/sharde/font_responsive.dart';

class TimePickerWidget extends StatefulWidget {
  final Color fillColor;
  double heightH;
  double widthH;

  TimePickerWidget({
    super.key,
    this.fillColor = const Color(0xff45596B),
    this.heightH = 40,
    this.widthH = 100,
  });

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? _selectedTime;
  String? formattedTime;
  Timer? _timer; // Create a variable to hold the Timer

  @override
  void initState() {
    super.initState();
    formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        formattedTime = DateFormat('hh:mm a').format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;

        final now = DateTime.now();
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute,
        );
        formattedTime = DateFormat('hh:mm a').format(selectedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            height: widget.heightH,
            width: widget.widthH,
            decoration: BoxDecoration(
              color: widget.fillColor,
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                formattedTime!,
                textAlign: TextAlign.center,
                style: GoogleFonts.almarai(
                  color: Colors.black,
                  fontSize: getFontSize(context, 15),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
