import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/admin/admin_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/admin_service.dart';
import 'package:ybb_master_app/core/services/program_category_service.dart';
import 'package:ybb_master_app/core/services/program_service.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/admin_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/reviewers/auth.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  getProgramData() async {
    try {
      await ProgramCategoryService().getAll().then((value) async {
        Provider.of<ProgramProvider>(context, listen: false).programCategories =
            value;

        await ProgramService().getAll().then((value) {
          Provider.of<ProgramProvider>(context, listen: false).programs = value;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  decideWhichAdmin(AdminModel admin) {
    Provider.of<AdminProvider>(context, listen: false).currentAdmin = admin;

    getProgramData();

    switch (admin.role) {
      case 'super':
        // go to admin dashboard
        context.pushNamed(AppRouteConstants.welcomeRouteName);
        break;
      case 'program':
        // get the program data from programs
        for (var program
            in Provider.of<ProgramProvider>(context, listen: false).programs) {
          if (admin.programId == program.id) {
            Provider.of<ProgramProvider>(context, listen: false)
                .currentProgram = program;
          }
        }

        // go to moderator dashboard
        context.pushNamed(AppRouteConstants.dashboardRouteName);
        break;
      default:
        // go to user dashboard
        break;
    }
  }

  signIn() async {
    // sign in logic
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // if the email and password is not empty, then sign in
      String email = emailController.text;
      String password = passwordController.text;

      await AdminService().login(email, password).then((value) {
        decideWhichAdmin(value);
      }).onError((error, stackTrace) {
        CommonHelper().showError(context, error.toString());
      });
    } else {
      // show an error message with pop up dialog
      CommonHelper().showError(context, "Please fill in all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // show a welcome image
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Image.asset(
            'assets/images/ybb_full_logo.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // create a text with the text "Sign in" using the text widget and style it with a font size of 30 and bold
                Text(
                  'Welcome back, Admin!',
                  style: AppTextStyleConstants.headingTextStyle,
                ),
                const SizedBox(height: 30),
                Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Column(
                      children: [
                        //create a text field for email input with the label "Email" and a hint "Enter your email" using text form field widget
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // add a decoration to the text field with a border and a label
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            hintText: 'Enter your email',
                          ),
                        ),
                        const SizedBox(height: 20),
                        // create a text field for password input with the label "Password" and a hint "Enter your password" using text form field widget
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          // add a decoration to the text field with a border and a label
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password',
                          ),
                        ),
                        const SizedBox(height: 40),
                        // create a button to sign in with the text "Sign in" using the elevated button widget and color it blue, make the width as big as the parent
                        isLoading
                            ? const LoadingWidget()
                            : CommonWidgets().buildCustomButton(
                                width: double.infinity,
                                color: Colors.blue,
                                text: "Sign in",
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  String email = "ival@gmail.com";
                                  String password = "123";

                                  await AdminService()
                                      .login(email, password)
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });

                                    decideWhichAdmin(value);
                                  }).onError((error, stackTrace) {
                                    setState(() {
                                      isLoading = false;
                                    });

                                    CommonHelper()
                                        .showError(context, error.toString());
                                  });
                                },
                              ),
                        const SizedBox(height: 20),
                        CommonWidgets().buildCustomButton(
                          width: double.infinity,
                          color: Colors.green,
                          text: "Sign in as Reviewer",
                          onPressed: () {
                            context.pushNamed(ReviewerSignin.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
