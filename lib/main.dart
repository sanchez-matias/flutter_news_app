import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/services/injection_container.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote/remote_articles_bloc.dart';
import 'package:flutter_news_app/src/news/presentation/bloc/remote_search_cubit/search_cubit.dart';
import 'package:flutter_news_app/src/news/presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
