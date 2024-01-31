import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/widgets/custom_text_field.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _SigninState();
}

class _SigninState extends State<Auth> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // create a from with email and password
              SizedBox(
                height: 100,
                child: buildCustomTextFormField(
                    labelText: "Email",
                    hintText: "email",
                    controller: controller,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress),
              )
              // create a button to sign in
            ],
          ),
        ),
        // show a welcome image
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Image.network(
            'https://picsum.photos/250?image=9',
            fit: BoxFit.contain,
          ),
        ),
      ],
    ));
  }
}
