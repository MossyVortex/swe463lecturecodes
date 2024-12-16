import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/local_datasource.dart';
import 'package:swe_463_arch_testing_lec/article/data/data_sources/remote_datasource.dart';
import 'package:swe_463_arch_testing_lec/article/presentation/pages/home_screen.dart';

import 'article/data/repositories/article_repository_implementation.dart';
import 'article/domain/repositories/article_repository.dart';
// The MyApp class is the entry point of the Flutter application.
// It is responsible for setting up the dependencies and gluing together the different layers of the clean architecture.
// This class creates instances of the RemoteDataSource and LocalDataSource, which are used for fetching articles from a remote API and local storage, respectively.
// It then creates an instance of ArticleRepositoryImpl, passing the data sources to it. The repository serves as a bridge between the data layer and the presentation layer.
// Finally, the MyApp class builds the MaterialApp widget, setting the HomeScreen widget as the home page. The HomeScreen widget receives the ArticleRepository as a dependency, allowing it to fetch and display articles to the user.

class MyApp extends StatelessWidget {
// In the MyApp class, we prepare the dependencies for dependency injection,
// which is a design pattern used to implement IoC (Inversion of Control). 
// This pattern helps in managing the dependencies of different classes 
// in a more maintainable and testable way.

// Here, we manually create instances of RemoteDataSource and LocalDataSource,
// and pass them to the ArticleRepositoryImpl. This manual process is suitable 
// for smaller applications with simpler dependency graphs. However, as the 
// application grows and the dependencies become more complex, it is recommended 
// to use packages like 'get_it', 'provider', or 'injectable'. These packages 
// offer advanced features such as singleton instances and lazy loading, 
// making it easier to manage and optimize dependencies in a large-scale 
// application.

  final RemoteDataSource remoteDataSource = RemoteDataSource(
      apiUrl: 'https://jsonplaceholder.typicode.com/posts',
      httpClient: Client());
  final LocalDataSource localDataSource = LocalDataSource();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleRepository articleRepository = ArticleRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    return MaterialApp(
      title: 'Article App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(articleRepository: articleRepository),
    );
  }
}
