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
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
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
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(element.avatar),
                ),
                title: Text(element.title),
                subtitle: Text(element.description),
                isThreeLine: true,
              );
            }),
      ),
    );
  }
}
