import 'package:flutter/material.dart';
import 'package:flutter_km_test/components/custom_elevated_button.dart';
import 'package:flutter_km_test/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController sentenceController = TextEditingController();

  void checkPalindrome(String sentence) {
    String sentenceModyfied = sentence.replaceAll(" ", "").toLowerCase();
    String reversedSentence = String.fromCharCodes(sentenceModyfied.runes.toList().reversed);

    bool isPalindrome = sentenceModyfied == reversedSentence;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isPalindrome ? "Palindrome" : "Not Palindrome"),
          content: Text(
            isPalindrome ? "isPalindrome" : "not palindrome",
            style: TextStyle(color: isPalindrome ? Colors.green : Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  void goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(userName: nameController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(32, 142, 32, 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/ic_photo.png'), width: 100, height: 100),
              const SizedBox(height: 50),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Color(0xFFE2E3E4), width: 1.0),
                  ),
                  hintStyle: TextStyle(color: Color(0xFF686777), fontSize: 16),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: sentenceController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Color(0xFFE2E3E4), width: 1.0),
                  ),
                  hintStyle: TextStyle(color: Color(0xFF686777), fontSize: 16),
                  hintText: 'Palindrome',
                ),
              ),
              const SizedBox(height: 45),
              CustomElevatedButton(
                onPressed: () => checkPalindrome(sentenceController.text),
                text: 'CHECK',
              ),
              const SizedBox(height: 15),
              CustomElevatedButton(
                onPressed: goToNextScreen,
                text: 'NEXT',
              )
            ],
          ),
        ),
      ),
    );
  }
}
