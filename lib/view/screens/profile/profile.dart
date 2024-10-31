import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_wash_light/constants/app_colors.dart';
import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/controllers/location_controller.dart';
import 'package:car_wash_light/view/screens/launch/forget_password.dart';
import 'package:car_wash_light/view/screens/launch/splash_screen.dart';
import 'package:car_wash_light/view/screens/profile/about.dart';
import 'package:car_wash_light/view/widget/toast_message.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    final LocationController location = Get.find<LocationController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(auth),
          SliverToBoxAdapter(
            child: _buildProfileOptions(context, auth, location),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(AuthController auth) {
    return SliverAppBar(
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [darkGreen, Colors.teal.shade700],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: auth.imageUrl.value.isNotEmpty
                            ? NetworkImage(auth.imageUrl.value)
                            : null,
                        backgroundColor: Colors.white,
                        child: auth.imageUrl.value.isEmpty
                            ? Icon(Icons.person, size: 70, color: darkGreen)
                            : null,
                      ),
                      if (auth.imageLoading.value)
                        Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  )),
              const SizedBox(height: 15),
              Text(
                auth.userName.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              //ADDING EMAIL TEXT HERE

              Text(
                auth.emailText.value,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  auth.changeImageLoading(true);
                  await auth.pickFileAndUpload();
                  auth.changeImageLoading(false);
                },
                icon: const Icon(Icons.camera_alt, color: darkGreen),
                label: const Text("Change Photo",
                    style: TextStyle(color: darkGreen)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOptions(
      BuildContext context, AuthController auth, LocationController location) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildOptionTile(
            title: "Location",
            icon: Icons.location_on,
            onTap: () => location.requestLocationAndLaunchMap(),
          ),
          _buildOptionTile(
            title: "Change Password",
            icon: Icons.lock,
            onTap: () => Get.to(() => ForgetPassword(
                  appBarText: 'Change password',
                  bodyText: 'Change your password',
                  buttonString: 'Change',
                )),
          ),
          _buildOptionTile(
            title: "About",
            icon: Icons.info,
            onTap: () => Get.to(() => About()),
          ),
          _buildOptionTile(
            title: "Sign Out",
            icon: Icons.exit_to_app,
            color: Colors.red,
            onTap: () async {
              String? result = await auth.signOut();
              if (result != null) {
                showToast(result, Colors.green);
                Get.off(() => SplashScreen());
              } else {
                showToast("Sign out failed!", Colors.red);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: color),
        onTap: onTap,
      ),
    );
  }
}
