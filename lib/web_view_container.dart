import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview/login.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {

   final controller =  WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://platform.openai.com/docs/overview'));

//  final logincontroller =  WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..loadRequest(Uri.parse('https://auth0.openai.com/u/login/identifier?state=hKFo2SBFSTRYREhVSDJiTzE0NmxwSWR1UldOWnJOQnJTR3NIRKFur3VuaXZlcnNhbC1sb2dpbqN0aWTZIG45enEtV1U4MjRBaC1NZExiSU1aZkdJV2IzNWFaalVmo2NpZNkgRFJpdnNubTJNdTQyVDNLT3BxZHR3QjNOWXZpSFl6d0Q'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web View"),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      body: Center(child: WebViewWidget(controller: controller)),
    );
  }
}