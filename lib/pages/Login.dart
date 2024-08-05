import 'package:chatapplication/Service/authantication.dart';
import 'package:chatapplication/Widgets/snakbar.dart';
import 'package:chatapplication/pages/Signup.dart';
import 'package:chatapplication/pages/homePage.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;
  void login() async {
    String res = await AuthServices().loginUser(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      isLoading = false;
      showSnakbar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 74, 73, 73),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter the email',
                  prefixIcon: Icon(Icons.person), // Add an icon
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'enter the password',
                  prefixIcon: Icon(Icons.lock), // Add an icon
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shadowColor: const Color.fromARGB(255, 0, 0, 0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
