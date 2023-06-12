import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpagination/pagination/post_bloc.dart';
import 'package:flutterpagination/pagination_without_bloc/product_lis.dart';
import 'package:flutterpagination/repo/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(

      create: (BuildContext context) => PostRepo(),
      child: BlocProvider<PostBloc>(
        create: (context) => PostBloc(context.read<PostRepo>())..add(FetchPostEvent()),
        child: MaterialApp(
          title: 'Flutter Demo',

          home: const ProductScreen(),
        ),
      ),
    );
  }
}
