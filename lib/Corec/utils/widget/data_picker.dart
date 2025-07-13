import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../corec/sharde/font_responsive.dart';

class DatePickerWidget extends StatefulWidget {
  final Color fillColor;
  final double heightH;
  final double widthH;
  final Function(DateTime?)? onDateSelected;

  const DatePickerWidget({
    super.key,
    this.fillColor = const Color(0xff45596B),
    this.heightH = 40,
    this.widthH = 100,
    this.onDateSelected,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;
  String? formattedDate = DateFormat(
    'yyyy/MM/dd',
    'en_US',
  ).format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        formattedDate = DateFormat('yyyy/MM/dd', 'en_US').format(picked);
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(_selectedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () => _selectDate(context),
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
                formattedDate!,
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
