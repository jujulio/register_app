import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:register_app/controller/register_controller.dart';
import 'package:register_app/model/register.dart';
import 'package:register_app/screen/register/create_register.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RegisterController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<RegisterController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Registros"),
      ),
      body: Consumer<RegisterController>(builder: (context, controller, child) {
        return FutureBuilder(
            future: controller.get(),
            builder: (context, snapshot) {
              if (!controller.isLoading) {
                return controller.registerList.isEmpty
                    ? Center(child: Image.asset("assets/not-information.png"))
                    : Center(
                        child: ListView.builder(
                        itemCount: controller.registerList.length,
                        itemBuilder: (context, index) {
                          return buildRegisterInfo(
                              controller.registerList[index]);
                        },
                      ));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CreateRegister(
                      register: null,
                    )),
          )
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildRegisterInfo(Register register) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateRegister(register: register)),
        );
      },
      child: Card(
        elevation: 10.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buttonDelete(context, register),
              textRegisterInfo(
                  icon: Icons.person_outlined,
                  typeField: "Nome",
                  description: register.name),
              textRegisterInfo(
                  icon: Icons.app_registration_outlined,
                  typeField: "${register.typeCharacter}",
                  description: register.cpfCnpj),
              textRegisterInfo(
                  icon: Icons.email_outlined,
                  typeField: "E-mail",
                  description: register.email),
              textRegisterInfo(
                  icon: Icons.home_outlined,
                  typeField: "Endereço",
                  description: register.address),
              textRegisterInfo(
                  icon: Icons.phone_outlined,
                  typeField: "Telefone",
                  description: register.phoneNumber),
              textRegisterInfo(
                  icon: Icons.calendar_month_outlined,
                  typeField: "Data de Nascimento",
                  description:
                      DateFormat('dd/MM/yyyy').format(register.birthday!)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonDelete(BuildContext context, Register register) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () =>
              Provider.of<RegisterController>(context, listen: false)
                  .remove(register),
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 26,
          ),
        )
      ],
    );
  }

  Widget textRegisterInfo({
    required IconData icon,
    required String typeField,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5.0,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
            color: Colors.blue,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "$typeField: $description",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
