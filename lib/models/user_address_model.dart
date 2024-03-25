import 'dart:convert';

UserAddressModel userAddressModelFromJson(String str) => UserAddressModel.fromJson(json.decode(str));

String userAddressModelToJson(UserAddressModel data) => json.encode(data.toJson());

class UserAddressModel {
  int id;
  int user;
  String streetAddress;
  String region;
  String district;
  String state;
  String postalCode;
  bool isDefault;

  UserAddressModel({
    required this.id,
    required this.user,
    required this.streetAddress,
    required this.region,
    required this.district,
    required this.state,
    required this.postalCode,
    required this.isDefault,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) => UserAddressModel(
        id: json["id"],
        user: json["user"],
        streetAddress: json["street_address"],
        region: json["region"],
        district: json["district"],
        state: json["state"],
        postalCode: json["postal_code"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "street_address": streetAddress,
        "region": region,
        "district": district,
        "state": state,
        "postal_code": postalCode,
        "is_default": isDefault,
      };
}
