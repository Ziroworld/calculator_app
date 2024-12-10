import 'package:flutter/material.dart';
import 'package:calculator_app/common/common_grid.dart';

class CalculatorDesingView extends StatefulWidget {
  const CalculatorDesingView({super.key});

  @override
  State<CalculatorDesingView> createState() => _CalculatorDesingViewState();
}

class _CalculatorDesingViewState extends State<CalculatorDesingView> {
  String result = "0"; // To display the result
  String firstValue = ""; // To store the first operand
  String secondValue = ""; // To store the second operand
  String operator = ""; // To store the operator

  static const List<String> buttonText = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "="
  ];

  void handleButtonPress(String value) {
    setState(() {
      if (value == "C") {
        // Reset all values
        result = "0";
        firstValue = "";
        secondValue = "";
        operator = "";
      } else if (value == "<-") {
        // Handle backspace
        if (result.isNotEmpty && result != "0") {
          result = result.substring(0, result.length - 1);
        }
        if (result.isEmpty) {
          result = "0";
        }
      } else if (value == "=") {
        // Perform calculation
        if (firstValue.isNotEmpty &&
            secondValue.isNotEmpty &&
            operator.isNotEmpty) {
          double num1 = double.parse(firstValue);
          double num2 = double.parse(secondValue);
          double finalResult = 0;

          switch (operator) {
            case "+":
              finalResult = num1 + num2;
              break;
            case "-":
              finalResult = num1 - num2;
              break;
            case "*":
              finalResult = num1 * num2;
              break;
            case "/":
              finalResult = num2 != 0
                  ? num1 / num2
                  : double.nan; // Prevent division by zero
              break;
            case "%":
              finalResult = num1 % num2;
              break;
          }

          result = finalResult.toString();
          firstValue = result; // Save result for further calculations
          secondValue = "";
          operator = "";
        }
      } else if ("+-*/%".contains(value)) {
        // Store the operator and set up for the second value
        if (firstValue.isEmpty) {
          firstValue = result; // Use the current result as the first value
        }
        operator = value;
        result = "0"; // Reset the display for second value input
      } else {
        // Handle number and decimal input
        if (result == "0") {
          result = value; // Replace initial zero
        } else {
          result += value; // Concatenate input
        }

        // Store values based on operator state
        if (operator.isEmpty) {
          firstValue = result;
        } else {
          secondValue = result;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Design'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Result display area
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            width: double.infinity,
            color: Colors.grey[200],
            child: TextField(
              decoration: InputDecoration(
                label: Text(' $result'),
              ),
            ),
          ),
          // Buttons grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: buttonText.length,
              itemBuilder: (context, index) {
                return CalculatorButton(
                  text: buttonText[index],
                  onTap: () => handleButtonPress(buttonText[index]),
                  backgroundColor: buttonText[index] == "="
                      ? Colors.blueAccent
                      : Colors.grey[300]!,
                  textColor:
                      buttonText[index] == "=" ? Colors.white : Colors.black,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
