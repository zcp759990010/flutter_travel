// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5','dp.ctrip.com/','m.ctrip.com/webapp/you/','www.chromestatus.com/'];
// class WebView extends StatefulWidget {
//   final String url;
//   final String statusBarColor;
//   final String title;
//   final bool hideAppBar;
//   final bool backForbid;
//   @override
//   _WebViewState createState() => new _WebViewState();
//
//   WebView({this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid});
// }
//
// class _WebViewState extends State<WebView> {
//   final webviewreference = FlutterWebviewPlugin();
//   StreamSubscription<String> _onurlchanged;
//   StreamSubscription<WebViewStateChanged> _onstatechanged;
//   StreamSubscription<WebViewHttpError> _onhttperror;
//   bool exiting = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     String statubarcolor = widget.statusBarColor ?? 'ffffff';
//     Color backcoclor;
//     if(statubarcolor == 'ffffff'){
//       backcoclor = Colors.black;
//     }else{
//       backcoclor = Colors.white;
//     }
//     print(widget.url);
//     return Scaffold(
//       body: Column(
//         children: [
//           _appBar(Color(int.parse('0xff'+ statubarcolor)),backcoclor),
//           Expanded(
//             child: WebviewScaffold(
//               url: widget.url,
//               withZoom: true,
//               withLocalStorage: true,
//               hidden: true,
//                 initialChild: Container(
//                   color: Colors.white,
//                   child: Center(
//                     child: Text('Wiating...'),
//                   ),
//                 ),
//             ),
//           ),
//         ],
//       ),
//     );
//
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     webviewreference.close();
//     _onurlchanged = webviewreference.onUrlChanged.listen((urlstring) {
//       print(urlstring);
//     });
//     _onstatechanged = webviewreference.onStateChanged.listen((WebViewStateChanged state) {
//       print(state.type);
//       switch (state.type) {
//         case WebViewState.shouldStart :
//           if (_isToMain(state.url)&&!exiting) {
//             if (widget.backForbid) {
//               webviewreference.launch(widget.url);
//             } else {
//               Navigator.pop(context);
//               exiting = true;
//             }
//           }
//           break;
//         default:
//           print(widget.url);
//           break;
//       }
//     });
//     _onhttperror = webviewreference.onHttpError.listen((WebViewHttpError error) {
//       print(error );
//       print("error");
//     });
//     webviewreference.launch(widget.url);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _onhttperror.cancel();
//     _onstatechanged.cancel();
//     _onurlchanged.cancel();
//     webviewreference.dispose();
//   }
//
//   _appBar(Color backgroundcoclor, Color backbtncolor) {
//     if(widget.hideAppBar??false){
//       return Container(
//         color: backgroundcoclor,
//         height: 20,
//       );
//     }else{
//       return Container(
//         child: FractionallySizedBox(
//           widthFactor: 1,
//           child: Stack(
//             children: [
//               GestureDetector(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 10),
//                   child: Icon(
//                     Icons.close,
//                     color: backbtncolor,
//                     size: 26,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Text(widget.title??"",style: TextStyle(color:  backbtncolor,fontSize: 20),),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
//
//   _isToMain(String url) {
//     bool contain = false;
//     for (final value in CATCH_URLS) {
//       if (url?.endsWith(value) ?? false) {
//         //  url 存在 才会调用endsWith
//         contain = true;
//         break;
//       }
//     }
//     print(contain);
//     return contain;
//   }
//
// }




import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//白名单
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5','dp.ctrip.com/','m.ctrip.com/webapp/you/','www.chromestatus.com/'];
class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {this.url,
        this.statusBarColor,
        this.title,
        this.hideAppBar,
        this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;

  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewReference.close(); //防止页面重新打开
    _onUrlChanged =
        webviewReference.onUrlChanged.listen((String url) {}); // url 变化的监听
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
          // h5 页面状态变化的监听
          switch (state.type) {
            case WebViewState.startLoad:
              if (_isToMain(state.url)&&!exiting) {
                if (widget.backForbid) {
                  webviewReference.launch(widget.url);
                } else {
                  Navigator.pop(context);
                  exiting = true;
                }
              }
              break;
            default:
              print(widget.url);
              break;
          }
        });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
          // h5 加载网络错误的监听
          print(error);
        });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        //  url 存在 才会调用endsWith
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
              child: WebviewScaffold(
                url: widget.url,
                withZoom: true,
                withLocalStorage: true,
                hidden: true,
                initialChild: Container(
                  //加载等待的界面
                  color: Colors.white,
                  child: Center(
                    child: Text('Waiting...'),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}