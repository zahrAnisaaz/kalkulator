import 'package:flutter/material.dart';

void main() {
  runApp(Kalkulator());
}

class Kalkulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculateScoreScreen(),
    );
  }
}

class CalculateScoreScreen extends StatefulWidget {
  @override
  _CalculateScoreScreenState createState() => _CalculateScoreScreenState();
}

class _CalculateScoreScreenState extends State<CalculateScoreScreen> {
  final TextEditingController score1Controller = TextEditingController();
  final TextEditingController score2Controller = TextEditingController();

  double? calculatedResult; // Variable to store the result
  String? gradeCategory; // Variable to store the grade category

  // Fungsi untuk menghitung rata-rata dan menentukan kategori
  void _calculate() {
    final score1 = double.tryParse(score1Controller.text);
    final score2 = double.tryParse(score2Controller.text);

    if (score1 != null && score2 != null) {
      setState(() {
        calculatedResult = (score1 + score2) / 2; // Rata-rata dari kedua nilai
        gradeCategory = _determineGradeCategory(calculatedResult!); // Menentukan kategori
      });
    } else {
      setState(() {
        calculatedResult = null; // Reset jika input salah
        gradeCategory = null; // Reset kategori juga
      });
    }
  }

  // Fungsi untuk menentukan kategori berdasarkan nilai rata-rata
  String _determineGradeCategory(double average) {
    if (average >= 85) {
      return 'A (85-100)';
    } else if (average >= 70) {
      return 'B (70-84)';
    } else if (average >= 55) {
      return 'C (55-69)';
    } else {
      return 'D (0-54)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hitung Nilai dan Kategori'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input nilai pertama
            TextField(
              controller: score1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Pertama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Input nilai kedua
            TextField(
              controller: score2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Kedua',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Tombol untuk menghitung
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Hitung Rata-rata dan Kategori'),
            ),

            SizedBox(height: 16),

            // Menampilkan hasil perhitungan rata-rata
            if (calculatedResult != null)
              Text(
                'Rata-rata dari kedua nilai: ${calculatedResult!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            else
              Text(
                'Masukkan nilai yang valid untuk menghitung.',
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 16),

            // Menampilkan kategori nilai
            if (gradeCategory != null)
              Text(
                'Kategori Nilai: $gradeCategory',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
