import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/presentation/admin/landingpage/admin-home/controllers/landingpage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// final List<Widget> _screens = [
//   //dashboard screen home analytics

//   Container(
//     color: AppColors.hint,
//     child: AdminHome(),
//   ),
//   // agents
//   Container(
//     child: Column(
//       children: [
//         Text('Agents'),
//         ElevatedButton(
//           onPressed: () {
//             Get.toNamed('/loginpage');
//           },
//           child: Text('Login'),
//         ),
//       ],
//     ),
//   ),

//   //listings
//   Container(
//     child: Column(
//       children: [
//         Text('Listings'),
//         ElevatedButton(
//           onPressed: () {
//             Get.toNamed('/loginpage');
//           },
//           child: Text('Login'),
//         ),
//       ],
//     ),
//   ),

//   //settings
//   Container(
//     child: Column(
//       children: [
//         Text('Settings'),
//         ElevatedButton(
//           onPressed: () {
//             Get.toNamed('/loginpage');
//           },
//           child: Text('Login'),
//         ),
//       ],
//     ),
//   ),

//   //messaging
//   Container(
//     child: Column(
//       children: [
//         Text('Settings'),
//         ElevatedButton(
//           onPressed: () {
//             Get.toNamed('/loginpage');
//           },
//           child: Text('Login'),
//         ),
//       ],
//     ),
//   ),
// ];

// RxInt _selectedIndex = 0.obs;

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.landingState.value) {
                LandingState.loading => _loading(),
                LandingState.loaded => _loaded(),
                LandingState.error => _error(),
                LandingState.empty => _empty()
              }),
        ),
      ),
      // bottomNavigationBar: Obx(() {
      //   return BottomNavigationBar(
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.people),
      //         label: 'Agents',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Listings',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.settings),
      //         label: 'Settings',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.message),
      //         label: 'Messaging',
      //       ),
      //     ],
      //     currentIndex: _selectedIndex.value,
      //     unselectedItemColor: AppColors.hint,
      //     selectedItemColor: AppColors.kRedColor,
      //     onTap: (index) {
      //       _selectedIndex.value = index;
      //       controller.update();
      //     },
      //   );
      // }),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return Row(
      children: [
        Container(
          width: 250,
          color: Colors.grey[200],
          child: _buildSidebarMenu(),
        ),
        // Expanded(child: _screens[_selectedIndex.value]),
      ],
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }
  Widget _buildSidebarMenu() {
    return ListView(
      children: [
        _buildExpansionTile(
          title: 'Dashboard',
          icon: Icons.dashboard,
          children: [
            _buildMenuItem('Home', Icons.home, () {
              // Navigate to home
              Get.toNamed('/home');
            }),
            _buildMenuItem('Analytics', Icons.analytics, () {
              // Navigate to analytics
              Get.toNamed('/analytics');
            }),
          ],
        ),
        _buildExpansionTile(
          title: 'Agents',
          icon: Icons.people,
          children: [
            _buildMenuItem('All Agents', Icons.list, () {
              // Navigate to all agents
              Get.toNamed('/agents/all');
            }),
            _buildMenuItem('Add Agent', Icons.person_add, () {
              // Navigate to add agent
              Get.toNamed('/agents/add');
            }),
          ],
        ),
        _buildExpansionTile(
          title: 'Listings',
          icon: Icons.home,
          children: [
            _buildMenuItem('All Listings', Icons.list, () {
              // Navigate to all listings
              Get.toNamed('/listings/all');
            }),
            _buildMenuItem('Add Listing', Icons.add_home, () {
              // Navigate to add listing
              Get.toNamed('/listings/add');
            }),
          ],
        ),
        _buildMenuItem('Settings', Icons.settings, () {
          // Navigate to settings
          Get.toNamed('/settings');
        }),
        _buildMenuItem('Messaging', Icons.message, () {
          // Navigate to messaging
          Get.toNamed('/messaging');
        }),
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

Widget _buildExpansionTile({
  required String title,
  required IconData icon,
  required List<Widget> children,
}) {
  return ExpansionTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: const SizedBox(),
    children: children,
  );
}
