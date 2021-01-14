import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_functions/bloc/album/bloc.dart';
import 'package:test_functions/bloc/album/events.dart';
import 'package:test_functions/bloc/album/states.dart';
import 'package:test_functions/model/albums_list.dart';

import '../bloc/album/bloc.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumBloc, AlbumState>(
            builder: (BuildContext context, AlbumState state) {
          if (state is AlbumErrorState) {
            final error = state.error;

            return Text(error.toString());
          }
          if (state is AlbumLoadedState) {
            List<Album> album = state.albums;
            return _listAlbum(album);
          }
          return CircularProgressIndicator();
        })
      ],
    );
  }

  _listAlbum(List<Album> album) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (_, index) {
        return Text(album[index].title);
      },
      itemCount: album.length,
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() {
    context.read<AlbumBloc>().add(AlbumEvents.fetchAlbums);
  }
}
