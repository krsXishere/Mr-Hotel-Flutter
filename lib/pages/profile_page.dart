import 'package:flutter/material.dart';
import 'package:mr_hotel/pages/sign_in_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../common/constant.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  navigate() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: const SignInPage(),
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

  Future<void> getData() async {
    Provider.of<UserProvider>(
      context,
      listen: false,
    ).user();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });

    return Consumer2<UserProvider, AuthProvider>(
      builder: (context, userProvider, authProvider, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: height(context) * 0.3,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      boxShadow: [
                        primaryShadow,
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: white,
                          radius: 50,
                          backgroundImage: NetworkImage(
                            "${userProvider.userModel?.profilePhotoURL}&size=100",
                          ),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          userProvider.userModel?.name.toString() ?? "",
                          style: secondaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          userProvider.userModel?.email.toString() ?? "",
                          style: secondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        )),
                    onPressed: () async {
                      if (await authProvider.signOut() &&
                          authProvider.authModel!.status == 200) {
                        navigate();
                      } else {
                        showSnackBar(
                          "Gagal keluar",
                          Colors.red,
                        );
                      }
                    },
                    child: Text(
                      "Keluar",
                      style: primaryTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
