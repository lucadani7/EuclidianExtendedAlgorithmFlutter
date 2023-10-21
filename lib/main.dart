import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Extended Euclidean Algorithm'),
          ),
          body: const EuclideanAlgorithm(),
        ),
      );
}

class EuclideanAlgorithm extends StatefulWidget {
  const EuclideanAlgorithm({super.key});

  @override
  State<StatefulWidget> createState() => _EuclideanAlgorithmState();
}

class _EuclideanAlgorithmState extends State<EuclideanAlgorithm> {
  int a = 0;
  int b = 0;
  int c = 0;
  String resultMessage = '';

  void calculateExtendedEuclideanAlgorithm() {
    StringBuffer resultBuffer = StringBuffer();
    String equation = "$a * x + $b * y = $c";
    resultBuffer.writeln('Equation: $equation');
    List<int> euclideanValues = euclideanExtended(a, b);
    int gcd = euclideanValues[0];
    int x = euclideanValues[1];
    int y = euclideanValues[2];

    if (b == 0) {
      resultBuffer.write('Equation has no solutions.');
    } else {
      if (c % gcd != 0) {
        resultBuffer.write('Equation has no solutions.');
      } else {
        if (c % gcd == 0) {
          int factor = c ~/ gcd;
          x *= factor;
          y *= factor;
          resultBuffer.write('Solutions: x = $x, y = $y');
        }
      }
      setState(() {
        resultMessage = resultBuffer.toString();
      });
    }
  }

  List<int> euclideanExtended(int a, int b) {
    if (a == 0) {
      return [b, 0, 1];
    }

    List<int> values = euclideanExtended(b % a, a);
    int gcd = values[0];
    int x = values[2] - (b ~/ a) * values[1];
    int y = values[1];

    return [gcd, x, y];
  }

  int euclidianAlgorithm(a, b) => b == 0 ? a : euclidianAlgorithm(b, a % b);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  a = int.tryParse(value) ?? 0;
                },
                decoration: const InputDecoration(
                  labelText: 'Type value for a',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  b = int.tryParse(value) ?? 0;
                },
                decoration: const InputDecoration(
                  labelText: 'Type value for b',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  c = int.tryParse(value) ?? 0;
                },
                decoration: const InputDecoration(
                  labelText: 'Type value for c',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: calculateExtendedEuclideanAlgorithm,
              child: const Text('Check solutions'),
            ),
            const SizedBox(height: 20),
            Text(
              resultMessage,
            ),
          ],
        ),
      );
}
