import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class CreateForm extends StatelessWidget {
  final Function(UserDM)? onSubmit;

  const CreateForm({
    super.key,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final roleController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final imageController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "Create Form",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "input name",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "input email",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: roleController,
            decoration: const InputDecoration(
              labelText: "Role",
              hintText: "input role",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: phoneNumberController,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              hintText: "input phone number",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: imageController,
            decoration: const InputDecoration(
              labelText: "Image",
              hintText: "image url",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              UserDM user = UserDM();
              user.name = nameController.text;
              user.email = emailController.text;
              user.role = roleController.text;
              user.phoneNumber = phoneNumberController.text;
              user.image = imageController.text;
              user.password = "password";

              if (onSubmit != null) onSubmit!(user);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
