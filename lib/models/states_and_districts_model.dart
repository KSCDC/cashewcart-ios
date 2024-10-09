import 'dart:convert';

StatesAndDistrictsModel statesAndDistrictsModelFromJson(String str) => StatesAndDistrictsModel.fromJson(json.decode(str));

String statesAndDistrictsModelToJson(StatesAndDistrictsModel data) => json.encode(data.toJson());

class StatesAndDistrictsModel {
  String state;
  List<String> districts;

  StatesAndDistrictsModel({
    required this.state,
    required this.districts,
  });

  factory StatesAndDistrictsModel.fromJson(Map<String, dynamic> json) => StatesAndDistrictsModel(
        state: json["state"],
        districts: List<String>.from(json["districts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "districts": List<dynamic>.from(districts.map((x) => x)),
      };
}
