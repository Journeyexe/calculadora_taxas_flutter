import 'package:calculadora_juros/pages/result_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComparadorDeJuros(title: 'C A L C U L A R    T A X A S'),
    );
  }
}

class ComparadorDeJuros extends StatefulWidget {
  const ComparadorDeJuros({super.key, required this.title});
  final String title;

  @override
  State<ComparadorDeJuros> createState() => _ComparadorDeJurosState();
}

class _ComparadorDeJurosState extends State<ComparadorDeJuros> {
  // Controladores para os campos de entrada da aplicação 1
  final TextEditingController capital1Controller = TextEditingController();
  final TextEditingController aplicacaoMensal1Controller = TextEditingController();
  final TextEditingController taxaJuros1Controller = TextEditingController();

  // Controladores para os campos de entrada da aplicação 2
  final TextEditingController capital2Controller = TextEditingController();
  final TextEditingController aplicacaoMensal2Controller = TextEditingController();
  final TextEditingController taxaJuros2Controller = TextEditingController();

  final TextEditingController mesesController = TextEditingController();

  void _calcularComparacao() {
    try {
      final double capital1 = double.parse(capital1Controller.text);
      final double aplicacaoMensal1 = double.parse(aplicacaoMensal1Controller.text);
      final double taxaJuros1 = double.parse(taxaJuros1Controller.text) / 100;

      final double capital2 = double.parse(capital2Controller.text);
      final double aplicacaoMensal2 = double.parse(aplicacaoMensal2Controller.text);
      final double taxaJuros2 = double.parse(taxaJuros2Controller.text) / 100;

      final int meses = int.parse(mesesController.text);

      double saldo1 = capital1;
      List<String> valores1 = [];
      for (int i = 0; i < meses; i++) {
        final rendimento1 = saldo1 * taxaJuros1;
        saldo1 += rendimento1 + aplicacaoMensal1;
        valores1.add('Mês ${i + 1}: R\$ ${rendimento1.toStringAsFixed(2)}');
      }

      // Cálculos para a aplicação 2
      double saldo2 = capital2;
      List<String> valores2 = [];
      for (int i = 0; i < meses; i++) {
        final rendimento2 = saldo2 * taxaJuros2;
        saldo2 += rendimento2 + aplicacaoMensal2;
        valores2.add('Mês ${i + 1}: R\$ ${rendimento2.toStringAsFixed(2)}');
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadosPage(
            montante1: saldo1,
            montante2: saldo2,
            detalhes1: valores1,
            detalhes2: valores2,
          ),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro"),
          content: const Text("Por favor, insira valores válidos."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Widget _campoTexto({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Aplicação 1",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _campoTexto(controller: capital1Controller, label: 'Investimento Inicial'),
            _campoTexto(controller: aplicacaoMensal1Controller, label: 'Aplicação Mensal'),
            _campoTexto(controller: taxaJuros1Controller, label: 'Taxa de Juros (%)'),
            const Divider(),
            const Text(
              "Aplicação 2",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _campoTexto(controller: capital2Controller, label: 'Investimento Inicial'),
            _campoTexto(controller: aplicacaoMensal2Controller, label: 'Aplicação Mensal'),
            _campoTexto(controller: taxaJuros2Controller, label: 'Taxa de Juros (%)'),
            const Divider(),
            _campoTexto(controller: mesesController, label: 'Período em Meses'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularComparacao,
              child: const Text('Comparar'),
            ),
          ],
        ),
      ),
    );
  }
}

