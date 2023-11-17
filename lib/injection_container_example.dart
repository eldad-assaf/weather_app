

// final sl = GetIt.instance;

// Future<void> initializeDependencies() async {
//   final database =
//       await $FloorAppDatabase.databaseBuilder('app_database.db').build();

//   sl.registerSingleton<AppDatabase>(database);

//   sl.registerSingleton<Dio>(Dio());

//   //Dependencies
//   sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

//   sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

//   //UseCases

//   sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

//   sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

//   sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

//   sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

//   //Blocs

//   sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
//   sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(sl(),sl(),sl()));
// }
