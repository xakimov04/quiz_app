import 'package:flutter/material.dart';

class Todo {
  final int id;
  String title;
  String description;
  DateTime date;
  TimeOfDay time;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });
}
