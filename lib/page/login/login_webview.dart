import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:github_me/common/style/g_style.dart';
import 'package:github_me/widget/g_common_option_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends StatefulWidget {
  final String url;
  final String title;

  LoginWebView(this.url, this.title);

  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  _renderTitle() {
    if (widget.url == null || widget.url.length == 0) {
      return new Text(widget.title);
    }
    return new Row(children: <Widget>[
      new Expanded(
        child: new Container(
          child: new Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GCommonOptionWidget(url: widget.url),
    ]);
  }

  final FocusNode focusNode = new FocusNode();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: _renderTitle(),
      ),
      body: new Stack(
        children: <Widget>[
          TextField(
            focusNode: focusNode,
          ),
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            navigationDelegate: (NavigationRequest navigation) {
              if (navigation.url != null && navigation.url.startsWith("gsygithubapp://authed")) {
                var code = Uri.parse(navigation.url).queryParameters["code"];
                print("code${code}");
                Navigator.of(context).pop(code);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            new Center(
              child: new Container(
                width: 200.0,
                height: 200.0,
                padding: new EdgeInsets.all(4.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SpinKitDoubleBounce(
                      color: Theme.of(context).primaryColor,
                    ),
                    new Container(width: 10.0),
                    new Container(
                      child: new Text(
                        GLocalizations.i18n(context).loading_text,
                        style: GConstant.middleText,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
