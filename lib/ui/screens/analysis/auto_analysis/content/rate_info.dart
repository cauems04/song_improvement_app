import 'package:flutter/material.dart';

enum RateType { terrible, bad, decent, good, perfect }

Map<RateType, Color> rateColors = {
  RateType.terrible: Colors.red,
  RateType.bad: Colors.orange,
  RateType.decent: Colors.yellow,
  RateType.good: Colors.blue,
  RateType.perfect: Colors.green,
};
