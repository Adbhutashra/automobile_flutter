import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vehicle_registration/Model/vehicleModel.dart';

class VehicleInformationScreen extends StatefulWidget {
  const VehicleInformationScreen({super.key});

  @override
  State<VehicleInformationScreen> createState() =>
      _VehicleInformationScreenState();
}

List<VehicleInfo> vehicleInfoList = [];

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController registrationNumberController =
      TextEditingController();
  final TextEditingController engineNumberController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController generalInfoController = TextEditingController();
  List<XFile>? _imageFiles = [];


  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        pickedFiles.forEach((element) {
          int randomId = DateTime.now().microsecondsSinceEpoch;
          File _imageFile = File(element.path);
          setState(() {
            _imageFiles = pickedFiles;
          });
        });
      });
    } else {
      print('No image selected.');
    }
  }

  void addVehicleInfo(BuildContext context) async {
     if (formKey.currentState!.validate()) {
      VehicleInfo vehicleInfo = VehicleInfo(
          registrationNumber: registrationNumberController.text,
          engineNumber: engineNumberController.text,
          company: companyController.text,
          generalInfo: generalInfoController.text,
          model: modelController.text,
          type: typeController.text,
          vehicleName: vehicleNameController.text,
          photos: _imageFiles!.join(','));

      vehicleInfoList.add(vehicleInfo);

      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: registrationNumberController,
                  decoration: InputDecoration(
                    labelText: 'Registration Number',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: engineNumberController,
                  decoration: InputDecoration(
                    labelText: 'Engine Number',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: modelController,
                  decoration: InputDecoration(
                    labelText: 'Model',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(
                    labelText: 'Type',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: companyController,
                  decoration: InputDecoration(
                    labelText: 'Company',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: vehicleNameController,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Name',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: generalInfoController,
                  decoration: InputDecoration(
                    labelText: 'Basic General Information',
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text('Upload Vehicle Photos'),
                ),
                if (_imageFiles != null && _imageFiles!.isNotEmpty)
                  Row(
                    children: _imageFiles!.map((file) {
                      return Image.file(
                        File(file.path),
                        height: 100,
                        width: 100,
                      );
                    }).toList(),
                  ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    addVehicleInfo(context);
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
