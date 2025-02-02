import 'package:flutter_test/flutter_test.dart';
import 'package:register_app/enum/type_character.dart';
import 'package:register_app/model/register.dart';

void main() {
  late Register register;

  setUp(() {
    register = Register();
  });

  test('Deve validar a criação do registro', () {
    final registerMock = Register();

    expect(registerMock, isA<Register>());
    expect(registerMock.name, "");
    expect(registerMock.id, null);
  });

  group("copyWith", () {
    test('Deve validar nome e o email no copyWith', () {
      register = Register(name: "João", email: "joao@teste.com");

      final Register registerCopy =
          register.copyWith(name: "João", email: "joao@teste.com");

      expect(registerCopy.name, register.name);
      expect(registerCopy.email, register.email);
    });

    test('Deve validar os campos null no copyWith', () {
      register = Register();

      final Register registerCopy = register.copyWith();

      expect(registerCopy.name, register.name);
      expect(registerCopy.email, register.email);
    });
  });

  test("Deve testar o toMap", () {
    register = Register(
      name: "João",
      email: "joao@teste.com",
      address: "Avenida Teste Alameda, 600",
      typeCharacter: TypeCharacter.CNPJ.name,
    );

    final registerMap = register.toMap();

    expect(registerMap["name"], register.name);
    expect(registerMap["email"], register.email);
    expect(registerMap["address"], register.address);
    expect(registerMap["typeCharacter"], register.typeCharacter);
  });

  test("Deve testar o fromMap", () {
    register = Register(
      name: "João",
      email: "joao@teste.com",
      address: "Avenida Teste Alameda, 600",
      typeCharacter: TypeCharacter.CNPJ.name,
      birthday: DateTime.now(),
    );

    final registerMap = register.toMap();
    final registerFromMap = Register.fromMap(registerMap);

    expect(registerFromMap.name, register.name);
    expect(registerFromMap.email, register.email);
    expect(registerFromMap.address, register.address);
    expect(registerFromMap.typeCharacter, register.typeCharacter);
  });

  test("Deve testar o toJson", () {
    register = Register(
      name: "João",
      email: "joao@teste.com",
      address: "Avenida Teste Alameda, 600",
      typeCharacter: TypeCharacter.CNPJ.name,
    );

    final registerJson = register.toJson();

    expect(registerJson.isNotEmpty, true);
    expect(registerJson, isA<String>());
  });

  test("Deve testar fromJson", () {
    register = Register(
      name: "João",
      email: "joao@teste.com",
      address: "Avenida Teste Alameda, 600",
      typeCharacter: TypeCharacter.CNPJ.name,
    );

    final registerJson = register.toJson();

    final registerFromJson = Register.fromJson(registerJson);

    expect(registerFromJson.name, register.name);
    expect(registerFromJson.email, register.email);
    expect(registerFromJson.address, register.address);
    expect(registerFromJson.typeCharacter, register.typeCharacter);
  });
}
