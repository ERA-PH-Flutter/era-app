import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../app/services/local_storage.dart';

enum ProjectsState {
  loading,
  loaded,
  error,
}

class ProjectsController extends GetxController {
  var store = Get.find<LocalStorageService>();

  List<WebViewController> webviews = [];

  final isLoading = true.obs;

  var urlList = [
    "https://livetour.istaging.com/1897223f-79f8-4d10-ad66-37bf1126bcf8?index=2",
    "https://my.matterport.com/show/?m=Nfso9YhjtJA&play=1",
    "https://livetour.istaging.com/d648d3c2-86bb-4f1d-9224-ff37d99c6d69",
    "https://livetour.istaging.com/ba0d3366-5267-4209-af73-a8841381dc44",
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeWebViews();
    isLoading.value = false;
  }

  void _initializeWebViews() {
    webviews = urlList.map((url) {
      var params = const PlatformWebViewControllerCreationParams();
      var webview = WebViewController.fromPlatformCreationParams(
        params,
        onPermissionRequest: (WebViewPermissionRequest request) {
          request.grant();
        },
      );

      webview
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              isLoading.value = true;
            },
            onPageFinished: (String url) {
              isLoading.value = false;
            },
            onWebResourceError: (WebResourceError error) {},
          ),
        )
        ..loadRequest(Uri.parse(url));

      return webview;
    }).toList();
  }
}
 

// class ProjectsController extends GetxController {
//   var store = Get.find<LocalStorageService>();
 
//   late WebViewController webview = WebViewController();
//   var url =
//       "livetour.istaging.com/1897223f-79f8-4d10-ad66-37bf1126bcf8?index=2";
//   final isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     var params = const PlatformWebViewControllerCreationParams();
//     webview = WebViewController.fromPlatformCreationParams(
//       params,
//       onPermissionRequest: (WebViewPermissionRequest request) {
//         request.grant();
//       },
//     );
//     webview
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {},
//           onPageStarted: (String url) {
//             isLoading.value = true;
//           },
//           onPageFinished: (String url) {
//             isLoading.value = false;
//             addFileSelectionListener();
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://$url'));
//     isLoading.value = false;
//   }

//   void addFileSelectionListener() async {
//     final androidController = webview.platform as AndroidWebViewController;
//     await androidController.setOnShowFileSelector(_androidFilePicker);
//   }

//   Future<List<String>> _androidFilePicker(
//       final FileSelectorParams params) async {
//     final result = await FilePicker.platform.pickFiles();

//     if (result != null && result.files.single.path != null) {
//       final file = File(result.files.single.path!);
//       return [file.uri.toString()];
//     }
//     return [];
//   }
 
