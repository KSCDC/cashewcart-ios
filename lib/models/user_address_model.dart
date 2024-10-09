import 'dart:convert';

UserAddressModel userAddressModelFromJson(String str) => UserAddressModel.fromJson(json.decode(str));

String userAddressModelToJson(UserAddressModel data) => json.encode(data.toJson());

class UserAddressModel {
  int id;
  int user;
  String name;
  String streetAddress;
  String region;
  String district;
  String state;
  String postalCode;
  String phoneNumber;
  bool isDefault;
  String deliveryChargePercentage;
  String additionalChargePercentage;

  UserAddressModel({
    required this.id,
    required this.user,
    required this.name,
    required this.streetAddress,
    required this.region,
    required this.district,
    required this.state,
    required this.postalCode,
    required this.phoneNumber,
    required this.isDefault,
    required this.deliveryChargePercentage,
    required this.additionalChargePercentage,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) => UserAddressModel(
        id: json["id"],
        user: json["user"],
        name: json["name"],
        streetAddress: json["street_address"],
        region: json["region"],
        district: json["district"],
        state: json["state"],
        postalCode: json["postal_code"],
        phoneNumber: json["phone_number"],
        isDefault: json["is_default"],
        deliveryChargePercentage: json["delivery_charge_percentage"],
        additionalChargePercentage: json["additional_charge_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "name": name,
        "street_address": streetAddress,
        "region": region,
        "district": district,
        "state": state,
        "postal_code": postalCode,
        "phone_number": phoneNumber,
        "is_default": isDefault,
      };
}
