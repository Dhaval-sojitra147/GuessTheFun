// To parse this JSON data, do
//
//     final celebData = celebDataFromJson(jsonString);

import 'dart:convert';

List<CelebData> celebDataFromJson(String str) => List<CelebData>.from(json.decode(str).map((x) => CelebData.fromJson(x)));

String celebDataToJson(List<CelebData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CelebData {
  String que;
  List<String> eyeOpenGrid;
  String photoName;
  List<String> hindiOption;
  String imageUrl;
  List<String> hint;
  String subLevelCategory;
  String hindiName;
  String levelCategory;
  String id;
  List<String> hindiHint;
  List<String> option;

  CelebData({
    required this.que,
    required this.eyeOpenGrid,
    required this.photoName,
    required this.hindiOption,
    required this.imageUrl,
    required this.hint,
    required this.subLevelCategory,
    required this.hindiName,
    required this.levelCategory,
    required this.id,
    required this.hindiHint,
    required this.option,
  });

  factory CelebData.fromJson(Map<String, dynamic> json) => CelebData(
    que: json["que"],
    eyeOpenGrid: List<String>.from(json["eyeOpenGrid"].map((x) => x)),
    photoName: json["photo_name"],
    hindiOption: List<String>.from(json["hindiOption"].map((x) => x)),
    imageUrl: json["image_url"],
    hint: List<String>.from(json["hint"].map((x) => x)),
    subLevelCategory: json["subLevel_category"],
    hindiName: json["hindi_name"],
    levelCategory: json["level_category"],
    id: json["id"],
    hindiHint: List<String>.from(json["hindiHint"].map((x) => x)),
    option: List<String>.from(json["option"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "que": que,
    "eyeOpenGrid": List<dynamic>.from(eyeOpenGrid.map((x) => x)),
    "photo_name": photoName,
    "hindiOption": List<dynamic>.from(hindiOption.map((x) => x)),
    "image_url": imageUrl,
    "hint": List<dynamic>.from(hint.map((x) => x)),
    "subLevel_category": subLevelCategory,
    "hindi_name": hindiName,
    "level_category": levelCategory,
    "id": id,
    "hindiHint": List<dynamic>.from(hindiHint.map((x) => x)),
    "option": List<dynamic>.from(option.map((x) => x)),
  };
}
