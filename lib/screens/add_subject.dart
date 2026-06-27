import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/grade_tracker_provider.dart';
import '../route/app_route.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({super.key});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add a subject',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Subject name'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a subject name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _markController,
                decoration: const InputDecoration(labelText: 'Mark (0-100)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final mark = int.tryParse(value ?? '');
                  if (mark == null) return 'Enter a valid mark';
                  if (mark < 0 || mark > 100) return 'Mark must be 0-100';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  context.read<GradeTrackerProvider>().addSubject(
                    _nameController.text.trim(),
                    int.parse(_markController.text),
                  );
                  _nameController.clear();
                  _markController.clear();
                  context.go(AppRoute.subjectListPath);
                },
                child: const Text('Add Subject'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
