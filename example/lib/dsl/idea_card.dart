import 'package:flutter/material.dart';

import 'global_config.dart';

class IdeaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: GlobalConfig.cardBackgroundColor,
        margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
        padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(left: 16.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 20.0,
                        child: Icon(Icons.all_inclusive, color: Colors.white),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "想法",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            "去往想法首页",
                            style: TextStyle(color: Colors.blue),
                          )),
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(right: 6.0),
                        decoration: BoxDecoration(
                            color: GlobalConfig.searchBackgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        "苹果 WWDC 2018 正在举行",
                                        style: TextStyle(
                                            color: GlobalConfig.dark == true
                                                ? Colors.white70
                                                : Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          "软件更新意料之中，硬件之谜...",
                                          style: TextStyle(
                                              color: GlobalConfig.fontColor),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 5,
                                child: AspectRatio(
                                    aspectRatio: 1.0 / 1.0,
                                    child: Container(
                                      foregroundDecoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://pic2.zhimg.com/50/v2-55039fa535f3fe06365c0fcdaa9e3847_400x224.jpg"),
                                            centerSlice: Rect.fromLTRB(
                                                270.0, 180.0, 1360.0, 730.0),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(6.0))),
                                    )))
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.only(right: 6.0),
                        decoration: BoxDecoration(
                            color: GlobalConfig.searchBackgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        "此刻你的桌子是什么样子？",
                                        style: TextStyle(
                                            color: GlobalConfig.dark == true
                                                ? Colors.white70
                                                : Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          "晒一晒你的书桌/办公桌",
                                          style: TextStyle(
                                              color: GlobalConfig.fontColor),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 5,
                                child: AspectRatio(
                                    aspectRatio: 1.0 / 1.0,
                                    child: Container(
                                      foregroundDecoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://pic3.zhimg.com/v2-b4551f702970ff37709cdd7fd884de5e_294x245|adx4.png"),
                                            centerSlice: Rect.fromLTRB(
                                                270.0, 180.0, 1360.0, 730.0),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(6.0))),
                                    )))
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.only(right: 6.0),
                        decoration: BoxDecoration(
                            color: GlobalConfig.searchBackgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        "关于高考你印象最深的是...",
                                        style: TextStyle(
                                            color: GlobalConfig.dark == true
                                                ? Colors.white70
                                                : Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          "聊聊你的高三生活",
                                          style: TextStyle(
                                              color: GlobalConfig.fontColor),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 5,
                                child: AspectRatio(
                                    aspectRatio: 1.0 / 1.0,
                                    child: Container(
                                      foregroundDecoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://pic2.zhimg.com/50/v2-ce2e01a047e4aba9bfabf8469cfd3e75_400x224.jpg"),
                                            centerSlice: Rect.fromLTRB(
                                                270.0, 180.0, 1360.0, 730.0),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(6.0))),
                                    )))
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.only(right: 6.0),
                        decoration: BoxDecoration(
                            color: GlobalConfig.searchBackgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        "夏天一定要吃的食物有哪些",
                                        style: TextStyle(
                                            color: GlobalConfig.dark == true
                                                ? Colors.white70
                                                : Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          "最适合夏天吃的那种",
                                          style: TextStyle(
                                              color: GlobalConfig.fontColor),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 5,
                                child: AspectRatio(
                                    aspectRatio: 1.0 / 1.0,
                                    child: Container(
                                      foregroundDecoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://pic1.zhimg.com/50/v2-bb3806c2ced60e5b7f38a0aa06b89511_400x224.jpg"),
                                            centerSlice: Rect.fromLTRB(
                                                270.0, 180.0, 1360.0, 730.0),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(6.0))),
                                    )))
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
