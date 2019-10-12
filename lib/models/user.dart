import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String userId;
  String firstName;
  String lastName;
  String email;
  String hotelId;
  String customerId;
  String profilePictureURL;
  int role;
  int seniority;
  bool shiftSunAM;
  bool shiftSunPM;
  bool shiftMonAM;
  bool shiftMonPM;
  bool shiftTueAM;
  bool shiftTuePM;
  bool shiftWedAM;
  bool shiftWedPM;
  bool shiftThuAM;
  bool shiftThuPM;
  bool shiftFriAM;
  bool shiftFriPM;
  bool shiftSatAM;
  bool shiftSatPM;  

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.hotelId,
    this.customerId,
    this.profilePictureURL,
    this.role,
    this.seniority,
    this.shiftSunAM,
    this.shiftSunPM,
    this.shiftMonAM,
    this.shiftMonPM,
    this.shiftTueAM,
    this.shiftTuePM,
    this.shiftWedAM,
    this.shiftWedPM,
    this.shiftThuAM,
    this.shiftThuPM,
    this.shiftFriAM,
    this.shiftFriPM,
    this.shiftSatAM,
    this.shiftSatPM,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        hotelId: json["hotelId"],
        profilePictureURL: json["profilePictureURL"],
        customerId: json["customerId"],
        role: json["role"],
        seniority:  json["seniority"],
        shiftSunAM: json["shiftSunAM"],
        shiftSunPM: json["shiftSunPM"],
        shiftMonAM: json["shiftMonAM"],
        shiftMonPM: json["shiftMonPM"],
        shiftTueAM: json["shiftTueAM"],
        shiftTuePM: json["shiftTuePM"],
        shiftWedAM: json["shiftWedAM"],
        shiftWedPM: json["shiftWedPM"],
        shiftThuAM: json["shiftThuAM"],
        shiftThuPM: json["shiftThuPM"],
        shiftFriAM: json["shiftFriAM"],
        shiftFriPM: json["shiftFriPM"],
        shiftSatAM: json["shiftSatAM"],
        shiftSatPM: json["shiftSatPM"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "hotelId": hotelId,
        "profilePictureURL": profilePictureURL,
        "role": role,
        "customerId": customerId,
        "seniority":seniority,
        "shiftSunAM": shiftSunAM,
        "shiftSunPM": shiftSunPM,
        "shiftMonAM": shiftMonAM,
        "shiftTueAM": shiftTueAM,
        "shiftTuePM": shiftTuePM,
        "shiftWedAM": shiftWedAM,
        "shiftWedPM": shiftWedPM,
        "shiftThuAM": shiftThuAM,
        "shiftThuPM": shiftThuPM,
        "shiftFriAM": shiftFriAM,
        "shiftFriPM": shiftFriPM,
        "shiftSatAM": shiftSatAM,
        "shiftSatPM": shiftSatPM,
      };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
