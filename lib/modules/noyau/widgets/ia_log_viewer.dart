/// Copilot Prompt : Widget IALogViewer pour AniSphère.
/// Affiche la liste des logs IA locaux enregistrés dans Hive.
/// Sert au debug, à la maintenance, ou au retour utilisateur avancé.
/// Peut être affiché dans une page "À propos", "Debug", ou panneau IA.
import 'package:flutter/material.dart';
import '../logic/ia_logger.dart';

class IALogViewer extends StatefulWidget {
  const IALogViewer({super.key});

  @override
  State<IALogViewer> createState() => _IALogViewerState();
}

class _IALogViewerState extends State<IALogViewer> {
  List<String> logs = [];

  @override
  void initState() {
    super.initState();
    logs = IALogger.getLogs().reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("🧠 Journaux IA"),
      subtitle: Text("${logs.length} événements enregistrés"),
      children: [
        if (logs.isEmpty)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Aucun log IA disponible."),
          )
        else
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                leading: const Icon(Icons.chevron_right),
                title: Text(logs[index]),
              ),
            ),
          ),
      ],
    );
  }
}
