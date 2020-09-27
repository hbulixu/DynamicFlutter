import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final Color backgroundColor;

  const VideoCard({Key key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor /*GlobalConfig.cardBackgroundColor*/,
        margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
        padding:const EdgeInsets.only(top: 12.0, bottom: 8.0),
        child:  Column(
          children: <Widget>[
            Container(
                margin: const  EdgeInsets.only(left: 16.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 20.0,
                        child: Icon(Icons.videocam, color: Colors.white),
                        backgroundColor: Color(0xFFB36905),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "视频创作",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                         // onPressed: () {},
                          child: Text(
                            "拍一个",
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
                        width: exp1,
                        margin: const EdgeInsets.only(right: 6.0),
                        child: AspectRatio(
                            aspectRatio: 2.0,
                            child: Container(
                              foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://pic2.zhimg.com/50/v2-5942a51e6b834f10074f8d50be5bbd4d_400x224.jpg"),
                                    centerSlice: Rect.fromLTRB(
                                        270.0, 180.0, 1360.0, 730.0),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0))),
                            ))),
                    Container(
                        margin: const EdgeInsets.only(right: 6.0),
                        width: exp2,
                        child: AspectRatio(
                            aspectRatio:2.0,
                            child: Container(
                              foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://pic3.zhimg.com/50/v2-7fc9a1572c6fc72a3dea0b73a9be36e7_400x224.jpg"),
                                    centerSlice: Rect.fromLTRB(
                                        270.0, 180.0, 1360.0, 730.0),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0))),
                            ))),
                    Container(
                        margin: const EdgeInsets.only(right: 6.0),
                        width: exp2,
                        child: AspectRatio(
                            aspectRatio: 2.0,
                            child: Container(
                              foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://pic4.zhimg.com/50/v2-898f43a488b606061c877ac2a471e221_400x224.jpg"),
                                    centerSlice: Rect.fromLTRB(
                                        270.0, 180.0, 1360.0, 730.0),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0))),
                            ))),
                    Container(
                        width: exp2,
                        child: AspectRatio(
                            aspectRatio: 2.0,
                            child: Container(
                              foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://pic1.zhimg.com/50/v2-0008057d1ad2bd813aea4fc247959e63_400x224.jpg"),
                                    centerSlice: Rect.fromLTRB(
                                        270.0, 180.0, 1360.0, 730.0),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0))),
                            )))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
