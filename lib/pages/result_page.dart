import 'package:flutter/material.dart';

class ResultadosPage extends StatelessWidget {
  final double montante1;
  final double montante2;
  final List<String> detalhes1;
  final List<String> detalhes2;

  const ResultadosPage({
    super.key,
    required this.montante1,
    required this.montante2,
    required this.detalhes1,
    required this.detalhes2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Montante Final (Aplicação 1): R\$ ${montante1.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...detalhes1.map((e) => ListTile(title: Text(e))),
            const Divider(),
            Text(
              "Montante Final (Aplicação 2): R\$ ${montante2.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...detalhes2.map((e) => ListTile(title: Text(e))),
          ],
        ),
      ),
    );
  }
}
