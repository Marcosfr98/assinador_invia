import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCustomWidget extends StatefulWidget {
  final String url;

  const WebViewCustomWidget({super.key, required this.url});

  @override
  State<WebViewCustomWidget> createState() => _WebViewCustomWidgetState();
}

class _WebViewCustomWidgetState extends State<WebViewCustomWidget> {
  double _sliderValue = 1;
  double _progress = 0;
  bool _isLoading = false;
  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          setState(() => _progress = progress.toDouble() / 100);
        },
        onPageStarted: (String url) {
          setState(() => _isLoading = true);
        },
        onPageFinished: (String url) {
          setState(() => _isLoading = false);
        },
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.url));

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          value: _progress,
          backgroundColor: Colors.blueAccent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      );
    } else {
      return Builder(
        builder: (context) {
          if (widget.url.isNotEmpty) {
            return Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async => await controller.canGoBack()
                                ? controller.goBack()
                                : () {},
                            icon: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.reload(),
                            icon: FaIcon(
                              FontAwesomeIcons.arrowsRotate,
                            ),
                          ),
                          IconButton(
                            onPressed: () async =>
                                await controller.canGoForward()
                                    ? controller.goForward()
                                    : () {},
                            icon: FaIcon(
                              FontAwesomeIcons.arrowRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 14,
                      child: WebViewWidget(
                        controller: controller,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 100,
                  right: 0,
                  bottom: 100,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: LayoutBuilder(builder: (context, size) {
                      return Slider(
                        activeColor: Colors.black,
                        inactiveColor: Colors.black,
                        thumbColor: Colors.blue,
                        value: _sliderValue,
                        max: size.maxHeight * 100,
                        onChanged: (value) async {
                          setState(() {
                            _sliderValue = value;
                          });
                          await controller.scrollTo(1, value.toInt() * 100);
                        },
                      );
                    }),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("url inválida!"),
            );
          }
        },
      );
    }
  }
}
