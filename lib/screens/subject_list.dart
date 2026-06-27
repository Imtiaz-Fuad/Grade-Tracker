import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grade_tracker_provider.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subjects = context.watch<GradeTrackerProvider>().subjects;

    if (subjects.isEmpty) {
      return Center(
        child: Text(
          'No subjects yet.',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];

        return Dismissible(
          key: ValueKey('${subject.name}-${subject.mark}-$index'),
          direction: DismissDirection.endToStart,
          background: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.error,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Icon(
                  Icons.delete,
                  color: theme.colorScheme.onError,
                ),
              ),
            ),
          ),
          onDismissed: (_) {
            context.read<GradeTrackerProvider>().deleteSubject(index);
          },
          child: Card(
            child: ListTile(
              title: Text(subject.name),
              subtitle: Text('Mark: ${subject.mark}'),
              trailing: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                child: Text(subject.grade),
              ),
            ),
          ),
        );
      },
    );
  }
}
