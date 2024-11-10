// class AuthenticationPageWeb extends GetView {
//   AuthenticationPageWeb({super.key});

//   @override
//   Widget build(BuildContext context) {
//     LoginPageController controller = Get.put(LoginPageController());
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding: EdgeInsets.all(EraTheme.paddingWidth + 20.w),
//             child: Column(
//               children: [
//                 Container(
//                   child: Image.asset(
//                     'assets/images/eraph_logo.png',
//                     fit: BoxFit.cover,
//                     height: Get.height / 2,
//                   ),
//                 ),

//                 SizedBox(
//                   width: 300.w,
//                   child: TextFormField(
//                     controller: email,
//                     style: TextStyle(color: AppColors.black, fontSize: 15.sp),
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       hintStyle: TextStyle(color: AppColors.hint),
//                       fillColor: AppColors.white,
//                       filled: true,
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: AppColors.black,
//                           width: 1,
//                         ),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Obx(
//                   () => SizedBox(
//                     width: 300.w,
//                     child: TextFormField(
//                       controller: pass,
//                       obscureText: isPasswordNotVisible.value,
//                       style: TextStyle(color: AppColors.black, fontSize: 15.sp),
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         hintStyle: TextStyle(color: AppColors.hint),
//                         fillColor: AppColors.white,
//                         filled: true,
//                         suffixIcon: IconButton(
//                           icon: Icon(isPasswordNotVisible.value
//                               ? CupertinoIcons.eye_fill
//                               : CupertinoIcons.eye_slash_fill),
//                           onPressed: () {
//                             isPasswordNotVisible.value =
//                                 !isPasswordNotVisible.value;
//                           },
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                             color: AppColors.black,
//                             width: 1,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//                 SizedBox(
//                   child: Column(
//                     children: [
//                       Button(
//                           width: 300.w,
//                           onTap: () async {
//                             BaseController().showLoading();
//                             var login = await Authentication()
//                                 .login(email: email.text, password: pass.text);
//                             if (FirebaseAuth.instance.currentUser != null) {
//                               BaseController().hideLoading();
//                               user = await EraUser().getById(
//                                   FirebaseAuth.instance.currentUser!.uid);
//                               if (user!.role!.toLowerCase() != "admin") {
//                                 user = null;
//                                 await Authentication().logout();
//                                 BaseController().showSuccessDialog(
//                                     title: "ERROR",
//                                     description:
//                                         "Please use admin account to have access!",
//                                     hitApi: () {
//                                       Get.back();
//                                     });
//                               } else {
//                                 Get.toNamed(RouteString.landingPage);
//                               }
//                             } else {
//                               BaseController().showSuccessDialog(
//                                   title: "ERROR",
//                                   description: "Password or email incorrect",
//                                   hitApi: () {
//                                     Get.back();
//                                     Get.back();
//                                   });
//                             }
//                           },
//                           text: "L O G I N",
//                           bgColor: AppColors.kRedColor,
//                           fontSize: 25.sp,
//                           fontWeight: FontWeight.w600,
//                           height: 48.h),
//                       SizedBox(height: 20.h),
//                       GestureDetector(
//                         onTap: () {
//                           // Get.toNamed("");
//                         },
//                         child: EraText(
//                           text: 'Forgot Password?',
//                           color: AppColors.black,
//                           fontSize: 18.sp,
//                         ),
//                       ),
//                       sb50(),
//                     ],
//                   ),
//                 ),
//                 //not final
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     // Get.toNamed("");
//                 //   },
//                 //   child: Container(
//                 //     margin: EdgeInsets.symmetric(
//                 //       horizontal: 40,
//                 //     ),
//                 //     height: 40.h,
//                 //     decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //       color: AppColors.blue,
//                 //     ),
//                 //     child: Row(
//                 //       mainAxisAlignment: MainAxisAlignment.center,
//                 //       children: [
//                 //         EraText(
//                 //           text: 'G',
//                 //           color: AppColors.white,
//                 //           fontSize: 30.sp,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //         SizedBox(width: 10.w),
//                 //         EraText(
//                 //           text: 'Sign in with Google',
//                 //           color: AppColors.white,
//                 //           fontSize: 15.sp,
//                 //           fontWeight: FontWeight.w400,
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
