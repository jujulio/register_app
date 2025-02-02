import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:register_app/controller/register_controller.dart';
import 'package:register_app/enum/type_character.dart';
import 'package:register_app/model/register.dart';
import 'package:register_app/widget/text_form_field_default.dart';
import 'package:validadores/Validador.dart';

class CreateRegister extends StatefulWidget {
  final Register? register;
  const CreateRegister({required this.register, super.key});

  @override
  State<CreateRegister> createState() => _CreateRegisterState();
}

class _CreateRegisterState extends State<CreateRegister> {
  final formKey = GlobalKey<FormState>();
  late RegisterController controller;
  late TextEditingController controllerCpfCnpj;
  late TextEditingController controllerBirthday;
  late Register registerdoc;

  @override
  void initState() {
    super.initState();
    controller = context.read<RegisterController>();
    widget.register == null
        ? registerdoc = controller.registerDefault()
        : registerdoc = widget.register!;

    controllerCpfCnpj = TextEditingController(
        text: widget.register == null ? "" : registerdoc.cpfCnpj);

    controllerBirthday = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(
            widget.register == null ? DateTime.now() : registerdoc.birthday!));

    widget.register == null
        ? controller.character = TypeCharacter.CPF
        : registerdoc.typeCharacter == TypeCharacter.CPF.name
            ? controller.character = TypeCharacter.CPF
            : controller.character = TypeCharacter.CNPJ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Criar Registro"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: formRegister(),
                ),
              ],
            ),
          ),
          buttonSave(context),
        ],
      ),
    );
  }

  Widget formRegister() {
    return Form(
        key: formKey,
        child: Card(
          elevation: 10.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 500,
              height: 590,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormFieldDefault(
                    labelText: "Nome",
                    maxLength: 30,
                    controller: TextEditingController(text: registerdoc.name),
                    validator: (value) {
                      registerdoc.name = value!;
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Obrigatório")
                          .validar(value);
                    },
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(
                      Icons.person_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Consumer<RegisterController>(
                      builder: (context, controller, child) {
                    return radioButton();
                  }),
                  Consumer<RegisterController>(
                      builder: (context, controller, child) {
                    return TextFormFieldDefault(
                      labelText: "CPF/CNPJ",
                      controller: controllerCpfCnpj,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        controller.isCpf()
                            ? controller.maskCpf
                            : controller.maskCNPJ
                      ],
                      validator: (value) {
                        registerdoc.cpfCnpj = controllerCpfCnpj.text;
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: 'Obrigatório')
                            .add(
                                controller.isCpf() ? Validar.CPF : Validar.CNPJ,
                                msg: '${controller.character.name} Inválido')
                            .valido(value);
                      },
                      prefixIcon: const Icon(
                        Icons.app_registration_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    );
                  }),
                  TextFormFieldDefault(
                    labelText: "E-mail",
                    keyboardType: TextInputType.emailAddress,
                    controller: TextEditingController(text: registerdoc.email),
                    validator: (value) {
                      registerdoc.email = value!;
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: 'Obrigatório')
                          .add(Validar.EMAIL, msg: 'E-mail Inválido')
                          .valido(value);
                    },
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  TextFormFieldDefault(
                    labelText: "Endereço",
                    controller:
                        TextEditingController(text: registerdoc.address),
                    validator: (value) {
                      registerdoc.address = value!;
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Obrigatório")
                          .validar(value);
                    },
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  TextFormFieldDefault(
                    labelText: "Telefone",
                    controller:
                        TextEditingController(text: registerdoc.phoneNumber),
                    validator: (value) {
                      registerdoc.phoneNumber = value!;
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Obrigatório")
                          .validar(value);
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [controller.maskPhone],
                    prefixIcon: const Icon(
                      Icons.phone_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  TextFormFieldDefault(
                    labelText: "Data de Nascimento",
                    controller: controllerBirthday,
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != DateTime.now()) {
                        controllerBirthday.text =
                            DateFormat('dd/MM/yyyy').format(picked);
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget radioButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RadioListTile<TypeCharacter>(
            activeColor: Colors.blue,
            title: const Text('CPF'),
            value: TypeCharacter.CPF,
            groupValue: controller.character,
            onChanged: (TypeCharacter? value) {
              controller.setRadioButton(value);
              registerdoc.typeCharacter = controller.character.name;
              controllerCpfCnpj.text = "";
            },
          ),
        ),
        Expanded(
          child: RadioListTile<TypeCharacter>(
            activeColor: Colors.blue,
            title: const Text('CNPJ'),
            value: TypeCharacter.CNPJ,
            groupValue: controller.character,
            onChanged: (TypeCharacter? value) {
              controller.setRadioButton(value);
              registerdoc.typeCharacter = controller.character.name;
              controllerCpfCnpj.text = "";
            },
          ),
        ),
      ],
    );
  }

  Widget buttonSave(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
        iconColor: WidgetStateProperty.all<Color>(Colors.white),
        iconSize: WidgetStateProperty.all<double>(35),
        minimumSize: WidgetStateProperty.all<Size>(const Size(70, 70)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.save_alt_outlined,
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "SALVAR",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      onPressed: () async {
        final form = formKey.currentState;
        if (form!.validate()) {
          await showDialogLoading(context);
          await Future.delayed(const Duration(seconds: 1), () async {
            await controller.save(registerdoc);
            if (context.mounted) Navigator.of(context).pop();
          });

          if (context.mounted) Navigator.of(context).pop();
        }
      },
    );
  }

  showDialogLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
