import 'package:flutter/material.dart';

bool checkTablet(BuildContext context) =>
MediaQuery.of(context).size.width > 800;
