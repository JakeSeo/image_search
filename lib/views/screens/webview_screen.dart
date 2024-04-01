import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 이미지의 출처 사이트를 표시하기위한 웹뷰 화면
class WebviewScreen extends StatefulWidget {
  static String path = "/webview";
  static String name = "webview";
  const WebviewScreen({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(widget.url);
            },
            icon: Icon(Icons.share, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
