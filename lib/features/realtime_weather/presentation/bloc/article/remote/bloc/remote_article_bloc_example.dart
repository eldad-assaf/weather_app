// import 'dart:developer';

// import 'package:clean_architecture/core/resources/data_state.dart';
// import 'package:clean_architecture/features/daily_news/domain/usecases/get_article.dart';
// import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_event.dart';
// import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RemoteArticlesBloc
//     extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
//   final GetArticleUseCase _articleUseCase;
//   RemoteArticlesBloc(this._articleUseCase)
//       : super(const RemoteArticlesLoading()) {
//     on<GetArticles>(onGetArticles);
//   }

//   void onGetArticles(
//       GetArticles event, Emitter<RemoteArticlesState> emit) async {
//     final dataState = await _articleUseCase();
//     if (dataState is DataSucess && dataState.data!.isNotEmpty) {
//       emit(RemoteArticlesDone(dataState.data!));
//     }
//     if (dataState is DataFailed) {
//       emit(RemoteArticlesError(dataState.error!));
//     }
//   }
// }
