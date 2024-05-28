import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteState with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
  }
  }

  void removeNote(int id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}
