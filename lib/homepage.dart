import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _bmi = 0;
  String _bmiResult = "";

  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);
      setState(() {
        _bmi = weight / (height * height);
        if (_bmi < 18.5) {
          _bmiResult = "Underweight";
        } else if (_bmi >= 18.5 && _bmi <= 24.9) {
          _bmiResult = "Normal";
        } else {
          _bmiResult = "Overweight";
        }
      });
    }
  }

  void _cancel() {
    _weightController.clear();
    _heightController.clear();
    setState(() {
      _bmi = 0;
      _bmiResult = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Calculate your BMI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: 'Height (m)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: _cancel,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _calculateBMI,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Calculate BMI', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'BMI: ${_bmi.toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                _bmiResult,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _bmiResult == "Underweight"
                      ? Colors.yellow
                      : _bmiResult == "Normal"
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
