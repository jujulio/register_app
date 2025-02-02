import 'dart:convert';

class Register {
  final String? id;
  String name;
  String cpfCnpj;
  String email;
  String phoneNumber;
  String address;
  String? typeCharacter;
  DateTime? birthday;

  Register({
    this.id,
    this.name = "",
    this.cpfCnpj = "",
    this.email = "",
    this.phoneNumber = "",
    this.address = "",
    this.typeCharacter,
    this.birthday,
  });

  copyWith({
    String? id,
    String? name,
    String? cpfCnpj,
    String? email,
    String? phoneNumber,
    String? address,
    String? typeCharacter,
    DateTime? birthday,
  }) {
    return Register(
      id: id ?? this.id,
      name: name ?? this.name,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      typeCharacter: typeCharacter ?? this.typeCharacter,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cpfCnpj': cpfCnpj,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'typeCharacter': typeCharacter,
      'birthday': birthday?.millisecondsSinceEpoch,
    };
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      cpfCnpj: map['cpfCnpj'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      typeCharacter: map['typeCharacter'] as String,
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(String source) =>
      Register.fromMap(json.decode(source) as Map<String, dynamic>);
}
