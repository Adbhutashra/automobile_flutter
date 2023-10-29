import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(int phoneNumber, String password) async {
    // Retrieve user data from the database based on the email
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData =
          await getUserData(phoneNumber, this.context);

      if (userData.isNotEmpty) {
        String storedPassword = userData['password'];
        if (password == storedPassword) {
          Navigator.pushNamed(this.context, '/home');
        } else {
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text('Password not matched')),
          );
        }
      } else {
        ScaffoldMessenger.of(this.context).showSnackBar(
          const SnackBar(content: Text('user not found')),
        );
        // User not found, login failed
        // Display an error message or take appropriate action
      }
    }
  }

  Future<Map<String, dynamic>> getUserData(
      int phoneNumber, BuildContext context) async {
    // Open the database
    String path = join(await getDatabasesPath(), 'database.db');
    Database database;

    try {
      database = await openDatabase(path);
    } catch (e) {
      // If the database doesn't exist, show an alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Database Error"),
            content: Text("Please register first."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      return {};
    }

    // Check if the 'registration' table exists in the database
    bool tableExists = (await database.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='registration'",
    ))
        .isNotEmpty;

    if (!tableExists) {
      // If the table doesn't exist, show an alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Table Not Found"),
            content: Text("Please register first."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      await database.close();
      return {};
    }

    // Retrieve user data from the database based on the provided phone number
    List<Map<String, dynamic>> results = await database.query(
      'registration',
      where: 'phonenumber = ?',
      whereArgs: [phoneNumber],
    );

    // Close the database
    await database.close();

    // Return the user data as a Map
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Phone Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    child: const Text(
                      "Don' have an account? Sign up",
                      style: TextStyle(color: Colors.blue),
                    )),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    login(int.parse(phoneNumberController.text),
                        passwordController.text);
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
