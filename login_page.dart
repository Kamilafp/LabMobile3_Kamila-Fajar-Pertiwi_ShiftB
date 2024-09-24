import 'package:flutter/material.dart';
import 'package:login3/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    usernameFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
  }

  Widget _inputField(TextEditingController controller, String placeholder, bool isPassword, FocusNode focusNode, Icon icon) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: placeholder,
        fillColor: focusNode.hasFocus ? Colors.lightBlue.shade50 : Colors.transparent,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.lightBlue, width: 2.0),
        ),
        prefixIcon: icon,
      ),
    );
  }

  void _showDialog(String pesan, Widget alamat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder( 
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(pesan),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => alamat,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth > 400 ? 400 : screenWidth * 0.85;

    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: cardWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.lightBlueAccent.shade100,
                        Colors.white,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title at the top inside the card
                      const Text(
                        'Login Page',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 50),
                      _inputField(_usernameController, 'Masukkan Username', false, usernameFocusNode, const Icon(Icons.person)),
                      const SizedBox(height: 15),
                      _inputField(_passwordController, 'Masukkan Password', true, passwordFocusNode, const Icon(Icons.lock)),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_usernameController.text == 'admin' &&
                              _passwordController.text == 'admin') {
                            _saveUsername();
                            _showDialog('Anda Berhasil Login', const HomePage());
                          } else {
                            _showDialog('Username dan Password Salah', const LoginPage());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 157, vertical: 17),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder( 
                            borderRadius: BorderRadius.circular(5.0), 
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
