
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_functions/bloc/album/events.dart';
import 'package:test_functions/bloc/album/states.dart';
import 'package:test_functions/model/albums_list.dart';
import 'package:test_functions/repository/exceptions.dart';
import 'package:test_functions/repository/services.dart';

class AlbumBloc extends Bloc<AlbumEvents,AlbumState>{
  List<Album> albums;
  final AlbumRepo albumRepo;
AlbumBloc({this.albumRepo}):super(AlbumInitState());
  @override
  Stream<AlbumState> mapEventToState(AlbumEvents event) async*{
switch(event){
  case AlbumEvents.fetchAlbums: yield AlbumLoadingState();
  try{
          albums = await albumRepo.getAlbumList();
          yield AlbumLoadedState(albums);
        }
       on SocketException {
 yield AlbumErrorState(error:NoInternetException(message:"No intternet exxception"));
        }
        on HttpException{
    yield AlbumErrorState(error:NoServiceException("Invalid service"));
        }
        on FormatException{

        }
        catch(e){
          yield AlbumErrorState(error:UnknownException(message:"unknown wxeption"));
  }
        break;
}
  }
}