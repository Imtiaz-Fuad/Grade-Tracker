import 'package:flutter/material.dart';

import '../models/subject.dart';

class GradeTrackerProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];
  bool _isDarkMode = false;

  List<Subject> get subjects => List.unmodifiable(_subjects);

  bool get isDarkMode => _isDarkMode;

  List<Subject> get passingSubjects =>
      _subjects.where((subject) => subject.mark >= 50).toList();

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0;
    final totalMarks = _subjects
        .map((subject) => subject.mark)
        .reduce((first, second) => first + second);
    return totalMarks / _subjects.length;
  }

  String get overallGrade {
    final average = averageMark;
    if (average >= 80) return 'A';
    if (average >= 65) return 'B';
    if (average >= 50) return 'C';
    return 'F';
  }

  void addSubject(String name, int mark) {
    _subjects.add(Subject(name: name, mark: mark));
    notifyListeners();
  }

  void deleteSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
