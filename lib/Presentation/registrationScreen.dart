import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    void register(BuildContext context) async {
    // Implement your registration logic here, e.g., validate and store user data

    // Perform registration, validation, or navigation as needed
    // For simplicity, we are printing the user details here
     if (formKey.currentState!.validate())  {
      await saveUserInformation().then((value) {
        Navigator.pushNamed(context, '/login');
      });
     }
  }

  Future<void> saveUserInformation() async {
    final database = openDatabase(
      // Specify the database path and name
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        // Create the registration table
        return db.execute(
          'CREATE TABLE IF NOT EXISTS registration(id INTEGER PRIMARY KEY, name TEXT, phoneNumber INTEGER, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
    final db = await database;

    await db.insert(
      'registration',
      {
        'name': nameController.text,
        'phoneNumber': phoneNumberController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                   validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                   validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Email';
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
                ElevatedButton(
                  onPressed: (){register(context);},
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
