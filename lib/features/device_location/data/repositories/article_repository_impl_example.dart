// import 'dart:io';

// import 'package:clean_architecture/core/resources/data_state.dart';
// import 'package:clean_architecture/features/daily_news/data/datasources/local/app_database.dart';
// import 'package:clean_architecture/features/daily_news/data/models/article.dart';
// import 'package:clean_architecture/features/daily_news/domain/entities/article.dart';
// import 'package:clean_architecture/features/daily_news/domain/repositories/article_repository.dart';
// import 'package:dio/dio.dart';
// import '../../../../core/constants/constants.dart';
// import '../datasources/remote/news_api_service.dart';

// class ArticleRepositoryImpl extends ArticleRepository {
//   final NewsApiService _newsApiService;
//   final AppDatabase _appDatabase;
//   ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

//   @override
//   Future<DataState<List<ArticleModel>>> getNewsArticale() async {
//     try {
//       final httpResponse = await _newsApiService.getNewsArticles(
//           apiKey: newsAPIKey, country: countryQuery, category: categoryQuery);

//       if (httpResponse.response.statusCode == HttpStatus.ok) {
//         return DataSucess(httpResponse.data);
//       } else {
//         return DataFailed(DioException(
//             error: httpResponse.response.statusMessage,
//             response: httpResponse.response,
//             type: DioExceptionType.badResponse,
//             requestOptions: httpResponse.response.requestOptions));
//       }
//     } on DioException catch (e) {
//       return DataFailed(e);
//     }
//   }

//   @override
//   Future<List<ArticleModel>> getSavedArticles() {
//     return _appDatabase.articleDao.getAllArticles();
//   }

//   @override
//   Future<void> removeArticle(ArticleEntity article) async {
//     _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
//   }

//   @override
//   Future<void> saveArticle(ArticleEntity article) {
//     return _appDatabase.articleDao
//         .insertArticle(ArticleModel.fromEntity(article));
//   }
// }
