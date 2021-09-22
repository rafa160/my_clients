class AddressModel {

  String place;
  String district;
  String city;
  String postalCode;
  String unit;

  AddressModel(
      {this.place, this.district, this.city, this.postalCode, this.unit});

  @override
  String toString() {
    return 'AddressModel{ $place, $district, $city, $postalCode, $unit}';
  }

  AddressModel.fromMap(Map<String, dynamic> map) {
    place = map['place'];
    district = map['district'];
    city = map['city'];
    postalCode = map['postal_code'];
    unit = map['unit'];
  }

  Map<String, dynamic> toMap() => {
    'place': place,
    'district': district,
    'city': city,
    'postal_code': postalCode,
    'unit': unit
  };
}