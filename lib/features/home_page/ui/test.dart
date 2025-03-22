import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:smart_home_app/core/widgets/app_text_button.dart';
import 'package:smart_home_app/features/home_page/widget/custom_container.dart';

class HomePageScreenTwo extends StatefulWidget {
  const HomePageScreenTwo({
    super.key,
  });

  @override
  State<HomePageScreenTwo> createState() => _HomePageScreenTwoState();
}

class _HomePageScreenTwoState extends State<HomePageScreenTwo> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  Future<DocumentSnapshot> getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
    }
    throw Exception("User not logged in");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    Logger logger = Logger(printer: PrettyPrinter());

    return FutureBuilder<DocumentSnapshot>(
      future: getData(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(child: Text("Something went wrong")),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Loading")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
              actions: [
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
                    logger.f("User Logged Out");
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            body: Center(child: Text("User data not found")),
          );
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        if (!data.containsKey('name')) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
              actions: [
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
                    logger.f("User Logged Out");
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            body: Center(child: Text("Name field does not exist")),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: FirebaseAuth.instance.currentUser!.emailVerified
                ? Row(
                    children: [
                      Text(
                        "Welcome, ${data['email']}",
                        style: TextStyles.font18WhiteMedium,
                      ),
                      Gap(5.w),
                      const Icon(
                        Icons.verified,
                      ),
                    ],
                  )
                : AppTextButton(
                    buttonText: "Verify your e-mail",
                    textStyle: TextStyles.font16WhiteSemiBold,
                    onPressed: () {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                    },
                  ),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
                  logger.f("User Logged Out");
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    // Handle the tap
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // Handle the tap
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.sp),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              physics: const BouncingScrollPhysics(),
              children: [
                CustomContainer(
                  onTap: () => GoRouter.of(context).push(AppRoutes.bathroom),
                  icon: Icons.bathroom,
                  title: 'Bathroom',
                ),
                CustomContainer(
                  onTap: () => GoRouter.of(context).push(AppRoutes.kitchen),
                  icon: Icons.kitchen,
                  title: 'Kitchen',
                ),
                // Add more CustomContainer widgets here
              ],
            ),
          ),
        );
      },
    );
  }
}
