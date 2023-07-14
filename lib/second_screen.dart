import 'package:flutter/material.dart';
import 'package:flutter_km_test/components/custom_elevated_button.dart';
import 'package:flutter_km_test/third_screen.dart';

class SecondScreen extends StatefulWidget {
  final String userName;
  const SecondScreen({super.key, required this.userName});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String selectedUserNameText = '';
  void goToThirdScreen(BuildContext context) async {
    final selectedUserName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThirdScreen()),
    );

    if (selectedUserName != null) {
      setState(() {
        selectedUserNameText = selectedUserName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFF04021D),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 12.0),
            ),
            Text(
              widget.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xFF04021D),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  selectedUserNameText != '' ? selectedUserNameText : 'Selected User Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Color(0xFF04021D),
                  ),
                ),
              ),
            ),
            CustomElevatedButton(
              onPressed: () => goToThirdScreen(context),
              text: "Choose a User",
            ),
          ],
        ),
      ),
    );
  }
}
