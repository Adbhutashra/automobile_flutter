class VehicleInfo {
  int? id;
  String registrationNumber;
  String engineNumber;
  String model;
  String type;
  String company;
  String vehicleName;
  String generalInfo;
  String photos;

  VehicleInfo({
    this.id,
    required this.registrationNumber,
    required this.engineNumber,
    required this.model,
    required this.type,
    required this.company,
    required this.vehicleName,
    required this.generalInfo,
    required this.photos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'registrationNumber': registrationNumber,
      'engineNumber': engineNumber,
      'model': model,
      'type': type,
      'company': company,
      'vehicleName': vehicleName,
      'generalInfo': generalInfo,
      'photos': photos,
    };
  }

  factory VehicleInfo.fromMap(Map<String, dynamic> map) {
    return VehicleInfo(
      id: map['id'],
      registrationNumber: map['registrationNumber'],
      engineNumber: map['engineNumber'],
      model: map['model'],
      type: map['type'],
      company: map['company'],
      vehicleName: map['vehicleName'],
      generalInfo: map['generalInfo'],
      photos: map['photos'],
    );
  }
}
