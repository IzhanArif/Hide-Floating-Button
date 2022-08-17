import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideFloatBtn extends StatefulWidget {
  const HideFloatBtn({Key? key}) : super(key: key);

  @override
  State<HideFloatBtn> createState() => _HideFloatBtnState();
}

class _HideFloatBtnState extends State<HideFloatBtn> {
  bool showFab = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF52595D),
      appBar: AppBar(
        title: const Text("Auto Hide FloatingActionButton"),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          setState(() {
            if (notification.direction == ScrollDirection.forward) {
              showFab = false;
            } else if (notification.direction == ScrollDirection.reverse) {
              showFab = true;
            }
          });

          return true;
        },
        child: ListView.builder(
            controller: _scrollController,
            itemCount: 200,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text("Item Number $index"),
              );
            })),
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              child: const Icon(Icons.arrow_downward_rounded),
              onPressed: () {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              })
          : null,
    );
  }
}
