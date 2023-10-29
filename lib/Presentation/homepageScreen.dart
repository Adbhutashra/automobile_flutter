import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_registration/Model/vehicleModel.dart';
import 'package:vehicle_registration/Presentation/vehicleInformationScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle List'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Navigate to the profile screen
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Text('Add More Vehicle'),
              onTap: () {
                // Navigate to the screen for adding more vehicles
                Navigator.pushNamed(context, '/vehicleinfo');
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Implement logout functionality
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: vehicleInfoList.length,
          itemBuilder: (context, index) {
            VehicleInfo vehicle = vehicleInfoList[index];
            
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                  title: Text(
                      'Registration Number: ${vehicle.registrationNumber}'),
                  subtitle: Column(
                    children: [
                      Text('Engine Number: ${vehicle.engineNumber}'),
                      Text('Model: ${vehicle.model}'),
                      Text('Company: ${vehicle.company.toString()}'),
                      Text('Type: ${vehicle.type}'),
                      Text('Vehicle Name: ${vehicle.vehicleName}'),
                      Text('General Info: ${vehicle.generalInfo}'),
                      
                      
                    ],
                  ),
                
                  ),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add More',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          // Handle bottom navigation item taps here
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/vehicleinfo');
          }
        },
      ),
    );
  }
}
