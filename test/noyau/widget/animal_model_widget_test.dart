import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class AnimalModelCard extends StatelessWidget {
  final String nom;
  final String espece;

  const AnimalModelCard({super.key, required this.nom, required this.espece});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(nom),
        subtitle: Text(espece),
      ),
    );
  }
}

void main() {
  testWidgets('ANIMAL_MODEL - Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AnimalModelCard(nom: 'Rex', espece: 'Chien'),
        ),
      ),
    );

    expect(find.text('Rex'), findsOneWidget);
    expect(find.text('Chien'), findsOneWidget);
  });
}
