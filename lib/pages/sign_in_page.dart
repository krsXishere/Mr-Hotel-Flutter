import 'package:flutter/material.dart';
import 'package:mr_hotel/pages/sign_up_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../common/constant.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button_auth_widget.dart';
import '../widgets/custom_button_question_auth_widget.dart';
import '../widgets/custom_textformfield_widget.dart';
import 'default_tab_bar_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  navigate() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: const DefaultTabBarPage(),
        type: PageTransitionType.rightToLeft,
      ),
      (Route<dynamic> route) => false,
    );
  }

  showSnackBar(
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: primaryTextStyle.copyWith(
            color: white,
          ),
        ),
      ),
    );
  }

  signIn(AuthProvider value) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (await value.signIn(emailController.text, passwordController.text) &&
          value.authModel!.status == 200) {
        navigate();
      } else if (value.authModel!.status == 422) {
        showSnackBar(
          value.authModel!.message.toString(),
          Colors.red,
        );
      } else if (value.authModel!.status == 500) {
        showSnackBar(
          "Server error",
          Colors.red,
        );
      } else {
        showSnackBar(
          "Gagal masuk\nError tidak diketahui",
          Colors.red,
        );
      }
    } else {
      showSnackBar(
        "Isi semua data",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: height(context) * 0.2,
                    ),
                    Center(
                      child: FlutterLogo(
                        size: 100,
                        textColor: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Center(
                      child: Text(
                        "Masuk Mr. Hotel",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Email",
                      label: "Email",
                      isPasswordField: false,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Kata sandi",
                      label: "Kata Sandi",
                      isPasswordField: true,
                      controller: passwordController,
                      type: TextInputType.text,
                      isObsecure: value.isObsecure,
                      onTap: () {
                        value.checkObsecure();
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomButtonAuthWidget(
                      text: "Masuk",
                      color: primaryColor,
                      isLoading: value.isLoading,
                      onPressed: () {
                        signIn(value);
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    const CustomButtonQuestionAuthWidget(
                      question: "Belum mendaftar?",
                      buttonText: "Daftar",
                      page: SignUpPage(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
