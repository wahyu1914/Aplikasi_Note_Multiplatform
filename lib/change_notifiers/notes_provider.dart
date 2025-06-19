import 'package:flutter/material.dart';
import 'package:project_note/models/note.dart';

import '../enums/order_option.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [..._notes]..sort(_compare);

  int _compare(Note note1, note2) {
    return _orderBy == OrderOption.dateModified
        ? _isDescending
              ? note2.dateModified.compareTo(note1.dateModified)
              : note1.dateModified.compareTo(note2.dateModified)
        : _isDescending
        ? note2.dateCreated.compareTo(note1.dateCreated)
        : note1.dateCreated.compareTo(note2.dateCreated);
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere(
      (element) => element.dateCreated == note.dateCreated,
    );
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  OrderOption _orderBy = OrderOption.dateModified;
  set orderBy(OrderOption value) {
    _orderBy = value;
    notifyListeners();
  }

  OrderOption get orderBy => _orderBy;

  bool _isDescending = true;
  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  bool _isGrid = true;
  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;
}
