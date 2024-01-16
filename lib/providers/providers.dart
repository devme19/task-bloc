import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/data/data_sources/local/local_data_source.dart';
import 'package:task/data/data_sources/remote/remote_data_source.dart';
import 'package:task/repository/repository.dart';

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  return LocalDataSourceImpl();
});
final remoteDataSourceProvider = Provider<RemoteDataSource>((ref){
  return RemoteDataSourceImpl();
});
final repositoryProvider = Provider<Repository>((ref){
  final localDataSource = ref.watch(localDataSourceProvider);
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return Repository(localDataSource: localDataSource,remoteDataSource: remoteDataSource);
});




