import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Ultilities', percent: 40, color: const Color(0xFF4D96FF)),
    Data(name: 'Food', percent: 30, color: const Color(0xFFFFD93D)),
    Data(name: 'Uneccessary', percent: 15, color: const Color(0xFFFF6B6B)),
    Data(name: 'Transportation', percent: 15, color: const Color(0xFF6BCB77)),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}