import 'package:flutter/material.dart';

/// 完全封装，用于演示自定义Widget
class InformationCard extends StatelessWidget {
  final Color backgroundColor; //GlobalConfig.cardBackgroundColor
  final bool dark; //GlobalConfig.dark
  final Color fontColor; //GlobalConfig.fontColor

  const InformationCard(
      {Key key, this.backgroundColor, this.dark, this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      margin: const EdgeInsets.only(top: 10.0, bottom: 6.0),
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            margin:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            decoration: BoxDecoration(
                color: dark == true ? Colors.white10 : Color(0xFFF5F5F5),
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: FlatButton(
                onPressed: () {},
                child: Container(
                  child: ListTile(
                    leading: Container(
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pic1.zhimg.com/v2-ec7ed574da66e1b495fcad2cc3d71cb9_xl.jpg"),
                          radius: 20.0),
                    ),
                    title: Container(
                      margin: const EdgeInsets.only(bottom: 2.0),
                      child: Text("learner"),
                    ),
                    subtitle: Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      child: Text("查看或编辑个人主页"),
                    ),
                  ),
                )),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width - 6.0) / 4,
                  child: FlatButton(
                      onPressed: () {},
                      child: Container(
                        height: 50.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "57",
                                style:
                                    TextStyle(fontSize: 16.0, color: fontColor),
                              ),
                            ),
                            Container(
                              child: Text(
                                "我的创作",
                                style:
                                    TextStyle(fontSize: 12.0, color: fontColor),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Container(
                  height: 14.0,
                  width: 1.0,
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          start: BorderSide(
                              color: dark ? Colors.white12 : Colors.black12,
                              width: 1.0))),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 6.0) / 4,
                  child: FlatButton(
                      onPressed: () {},
                      child: Container(
                        height: 50.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "210",
                                style:
                                    TextStyle(fontSize: 16.0, color: fontColor),
                              ),
                            ),
                            Container(
                              child: Text(
                                "关注",
                                style:
                                    TextStyle(fontSize: 12.0, color: fontColor),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                Container(
                  height: 14.0,
                  width: 1.0,
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          start: BorderSide(
                              color: dark ? Colors.white12 : Colors.black12,
                              width: 1.0))),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 6.0) / 4,
                  child: FlatButton(
                      onPressed: () {},
                      child: Container(
                        height: 50.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "18",
                                style:
                                    TextStyle(fontSize: 16.0, color: fontColor),
                              ),
                            ),
                            Container(
                              child: Text(
                                "我的收藏",
                                style:
                                    TextStyle(fontSize: 12.0, color: fontColor),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                Container(
                  height: 14.0,
                  width: 1.0,
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          start: BorderSide(
                              color: dark ? Colors.white12 : Colors.black12,
                              width: 1.0))),
                ),
                Container(
                    width: (MediaQuery.of(context).size.width - 6.0) / 4,
                    child: FlatButton(
                        onPressed: () {},
                        child: Container(
                          height: 50.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "33",
                                  style: TextStyle(
                                      fontSize: 16.0, color: fontColor),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "最近浏览",
                                  style: TextStyle(
                                      fontSize: 12.0, color: fontColor),
                                ),
                              )
                            ],
                          ),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
