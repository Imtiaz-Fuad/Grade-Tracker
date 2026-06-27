import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grade_tracker_provider.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tracker = context.watch<GradeTrackerProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SummaryCard(
              label: 'Total Subjects',
              value: tracker.totalSubjects.toString(),
            ),
            const SizedBox(height: 16),
            _SummaryCard(
              label: 'Average Mark',
              value: tracker.totalSubjects == 0
                  ? 'N/A'
                  : tracker.averageMark.toStringAsFixed(2),
            ),
            const SizedBox(height: 16),
            _SummaryCard(
              label: 'Overall Grade',
              value: tracker.totalSubjects == 0 ? 'N/A' : tracker.overallGrade,
            ),
            const SizedBox(height: 16),
            Text(
              'Passing Subjects: ${tracker.passingSubjects.length}',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
