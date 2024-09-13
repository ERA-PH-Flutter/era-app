// import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'add_project_admin.dart';

// class ProjectListView extends GetView<ListingsAdminController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Projects'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(48),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) => controller.filterProjects(value),
//               decoration: InputDecoration(
//                 hintText: 'Search by project name...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.listingState.value == ListingsAState.loading) {
//           return Center(child: CircularProgressIndicator());
//         } else if (controller.filteredProjects.isEmpty) {
//           return Center(child: Text("No projects available."));
//         }

//         return ListView.builder(
//           itemCount: controller.filteredProjects.length,
//           itemBuilder: (context, index) {
//             final project = controller.filteredProjects[index];
//             return ListTile(
//               title: Text(project),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: () {
//                       Get.to(() => AddProjectAdmin(projectName: project));
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       controller.deleteProject(index);
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
