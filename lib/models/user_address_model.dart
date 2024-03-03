

import 'dart:convert';

UserAddressModel userAddressModelFromJson(String str) => UserAddressModel.fromJson(json.decode(str));

String userAddressModelToJson(UserAddressModel data) => json.encode(data.toJson());

class UserAddressModel {
    int id;
    int user;
    String streetAddress;
    String city;
    String state;
    String postalCode;
    String country;
    bool isDefault;

    UserAddressModel({
        required this.id,
        required this.user,
        required this.streetAddress,
        required this.city,
        required this.state,
        required this.postalCode,
        required this.country,
        required this.isDefault,
    });

    factory UserAddressModel.fromJson(Map<String, dynamic> json) => UserAddressModel(
        id: json["id"],
        user: json["user"],
        streetAddress: json["street_address"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
        isDefault: json["is_default"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "street_address": streetAddress,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
        "is_default": isDefault,
    };
}
