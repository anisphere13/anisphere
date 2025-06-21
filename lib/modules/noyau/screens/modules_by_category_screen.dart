import 'package:flutter/material.dart';
import '../models/module_model.dart';

class ModulesByCategoryScreen extends StatelessWidget {
  final Map<String, List<ModuleModel>> modulesByCategory;
  const ModulesByCategoryScreen({super.key, required this.modulesByCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: modulesByCategory.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: entry.value
                      .map(
                        (m) => SizedBox(
                          width: 200,
                          child: Card(
                            child: Center(child: Text(m.name)),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        }),
      ),
    );
  }
}
