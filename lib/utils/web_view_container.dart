import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:move_to_earn/core/constants/colors.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final String link;
  final String name;
  WebViewContainer({
    Key? key,
    required this.link,
    required this.name,
  }) : super(key: key);

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late WebViewController controllerWeb;
  bool loadingWeb = true;
  double loadingProgress = 0.0;
  @override
  void initState() {
    super.initState();
    controllerWeb = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.link))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("Progress: $progress");
            setState(() {
              loadingProgress =
                  progress / 100; // Assuming progress is a percentage (0-100)
            });
          },
          onPageStarted: (String url) {
            setState(() {
              loadingWeb = true;
              print(loadingWeb);
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loadingWeb = false;
              print(loadingWeb);
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('qPay_QRcode')) {
              print(request.url);
              launchUrl(Uri.parse(request.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          InkWell(
            onTap: (() {
              Navigator.of(context).pop();
            }),
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.close),
            ),
          ),
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: white),
        title: Text(
          widget.name,
          style: TextStyle(color: white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: ColorConstants.backGradientColor3,
      ),
      body: loadingWeb == true
          ? Container(
              child: Stack(
                children: [
                  BackColor(),
                  Center(
                    child: Image.asset(
                      "assets/images/loading_logo.gif",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            )
          : WebViewWidget(controller: controllerWeb),
    );
  }
}
