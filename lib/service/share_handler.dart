import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_handler_platform_interface/share_handler_platform_interface.dart';
import '/service/thumbnail_search.dart';
import '/widgets/popup_links.dart';

// ShareHandlerService 负责初始化和监听分享内容
class ShareHandlerService {
  SharedMedia? media;

  Future<void> initPlatformState(BuildContext context) async {
    final handler = ShareHandlerPlatform.instance;
    media = await handler.getInitialSharedMedia();

    if (media?.content != null) {
      // 如果有分享内容，跳转到分享页面
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ShareReceiverPage(media: media!),
        ),
      );
    }

    handler.sharedMediaStream.listen((SharedMedia newMedia) {
      media = newMedia;
      if (media?.content != null) {
        // 如果有新的分享内容，跳转到分享页面
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShareReceiverPage(media: media!),
          ),
        );
      }
    });
  }
}

// ShareReceiverPage 负责显示和处理分享内容
class ShareReceiverPage extends StatefulWidget {
  final SharedMedia media;

  ShareReceiverPage({required this.media});

  @override
  _ShareReceiverPageState createState() => _ShareReceiverPageState();
}

class _ShareReceiverPageState extends State<ShareReceiverPage> {
  @override
  void initState() {
    super.initState();
    // 在页面加载完成后自动调用 handleText 方法
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleText(context);
    });
  }

  Future<void> handleText(BuildContext context) async {
      final  url = widget.media.content;
      if (url != null) {
        final aaa = await extractAndSearchUrls(url);
        showLinkButtonsPopup(context, aaa);
      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Receiver'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.media.content != null)
              Text("Shared Text: ${widget.media.content}"),
          ],
        ),
      ),
    );
  }
}
