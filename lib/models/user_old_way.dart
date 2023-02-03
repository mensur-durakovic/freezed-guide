import 'package:flutter/material.dart';

@immutable
class UserOldWay {
  final int id;
  final String name;
  final String username;

  const UserOldWay({
    required this.id,
    required this.name,
    required this.username,
  });

  factory UserOldWay.fromJson(Map<String, Object?> json) {
    return UserOldWay(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
    };
  }

  UserOldWay copyWith({
    int? id,
    String? name,
    String? username,
  }) {
    return UserOldWay(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return 'User('
        'id $id, '
        'name $name, '
        'username $username, '
        ')';
  }

  @override
  bool operator ==(covariant UserOldWay other) {
    return id == other.id && name == other.name && username == other.username;
  }

  @override
  int get hashCode {
    return Object.hashAll([id, name, username]);
  }
}
