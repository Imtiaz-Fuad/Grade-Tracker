import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/grade_tracker_provider.dart';
import '../screens/add_subject.dart';
import '../screens/subject_list.dart';
import '../screens/summary.dart';

final appRouter = GoRouter(
  initialLocation: AppRoute.addSubjectPath,
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppRoute(
        location: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: AppRoute.addSubjectPath,
          builder: (context, state) => const AddSubject(),
        ),
        GoRoute(
          path: AppRoute.subjectListPath,
          builder: (context, state) => const SubjectList(),
        ),
        GoRoute(
          path: AppRoute.summaryPath,
          builder: (context, state) => const Summary(),
        ),
      ],
    ),
  ],
);

class AppRoute extends StatelessWidget {
  const AppRoute({
    required this.location,
    required this.child,
    super.key,
  });

  static const addSubjectPath = '/add-subject';
  static const subjectListPath = '/subjects';
  static const summaryPath = '/summary';

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradeTracker = context.watch<GradeTrackerProvider>();
    final currentIndex = _currentIndexForPath(location);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grade Tracker'),
        actions: [
          IconButton(
            tooltip: gradeTracker.isDarkMode
                ? 'Switch to light theme'
                : 'Switch to dark theme',
            onPressed: context.read<GradeTrackerProvider>().toggleTheme,
            icon: Icon(
              gradeTracker.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: ColoredBox(
        color: theme.colorScheme.surface,
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _goToTab(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Summary',
          ),
        ],
      ),
    );
  }

  int _currentIndexForPath(String path) {
    return switch (path) {
      subjectListPath => 1,
      summaryPath => 2,
      _ => 0,
    };
  }

  void _goToTab(BuildContext context, int index) {
    final path = switch (index) {
      1 => subjectListPath,
      2 => summaryPath,
      _ => addSubjectPath,
    };
    context.go(path);
  }
}
