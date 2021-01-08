import 'package:equatable/equatable.dart';
import 'package:test_functions/model/albums_list.dart';

abstract class AlbumState extends Equatable{

  @override
  List<Object> get props=>[];
}
class AlbumInitState extends AlbumState{
}
class AlbumLoadingState extends AlbumState{
}
class AlbumLoadedState extends AlbumState{
final List<Album> albums;
AlbumLoadedState(this.albums);
}
class AlbumErrorState extends AlbumState{
final error;
AlbumErrorState({this.error});
}