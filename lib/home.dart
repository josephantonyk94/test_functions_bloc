import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_functions/bloc/album/bloc.dart';
import 'package:test_functions/repository/services.dart';
import 'package:test_functions/screens/album_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => AlbumBloc(albumRepo: AlbumServices()))
          ],
          child: AlbumScreen(),
        ));
  }
}
