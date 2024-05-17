import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:register_app/enum/type_character.dart';
import 'package:register_app/model/register.dart';
import 'package:register_app/repository/register_repository.dart';

class RegisterController extends ChangeNotifier {
  RegisterRepository repository;

  RegisterController({required this.repository});

  List<Register> _registerList = [];
  UnmodifiableListView<Register> get registerList =>
      UnmodifiableListView(_registerList);

  late TypeCharacter character;
  late Register defaultRegister;

  bool isCpf() => character == TypeCharacter.CPF;
  bool isLoading = true;

  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  final maskCNPJ = MaskTextInputFormatter(
      mask: "##.###.###/####-##", filter: {"#": RegExp(r'[0-9]')});

  final maskPhone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  Register registerDefault() {
    defaultRegister = Register(
      id: "",
      name: "",
      cpfCnpj: "",
      email: "",
      phoneNumber: "",
      address: "",
      typeCharacter: TypeCharacter.CPF.name,
      birthday: DateTime.now(),
    );
    return defaultRegister;
  }

  Future<void> get() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        _registerList = await repository.get();
        isLoading = false;
        notifyListeners();
      },
    );
  }

  setRadioButton(TypeCharacter? value) {
    character = value!;
    notifyListeners();
  }

  save(Register register) {
    (register.id == null || register.id!.isEmpty)
        ? insert(register)
        : update(register);
  }

  Future<void> insert(Register register) async {
    final registerData = await repository.insert(register);
    if (registerData != null) {
      _registerList.add(registerData);
      notifyListeners();
    }
  }

  Future<void> update(Register register) async {
    await repository.update(register);
    notifyListeners();
  }

  Future<void> remove(Register register) async {
    final registerData = await repository.remove(register);
    if (registerData != null) {
      _registerList.remove(registerData);
      notifyListeners();
    }
  }
}
