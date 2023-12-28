import 'package:flutter/material.dart';
import 'package:flutterrestgraphql/features/articles/ArticleManager.dart';
import 'package:flutterrestgraphql/helpers/Observer.dart';
import 'package:flutterrestgraphql/helpers/Overseer.dart';
import 'package:flutterrestgraphql/helpers/Provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: Overseer(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: MyHomePage(title: 'Dev.to.Mobile'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ArticleManager manager = Provider.of(context).fetch(ArticleManager);
    manager.inFilter.add('');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        stream: manager.browse$,
        onSuccess: (context, data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var element = data[index];
              return Card(
                child: Column(children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(element.avatar),
                    ),
                    title: Text(element.title),
                    subtitle: Column(
                      children: <Widget>[
                        Text(element.description),
                        Row(
                          children: <Widget>[
                            for (var tag in element.tags) Text("#$tag")
                          ],
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: Row(
                            children: <Widget>[
                              Image.network(
                                "https://practicaldev-herokuapp-com.freetls.fastly.net/assets/reactions-stack-ee166e138ca182a567f74c986b6f810f670f4d199aca9c550cc7e6f49f34bd33.png",
                                scale: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(element.reactionCount.toString()),
                              )
                            ],
                          )),
                        ],
                      ))
                ]),
              );
            }),
      ),
    );
  }
}
