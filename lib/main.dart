import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsse_cat_tinder/di.dart';
import 'package:hsse_cat_tinder/presentation/cubits/home_cubit.dart';
import 'package:hsse_cat_tinder/presentation/cubits/liked_cubit.dart';
import 'package:hsse_cat_tinder/presentation/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  setupDI();
  runApp(CatApp());
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LikedCubit>(create: (_) => getIt<LikedCubit>()),
        BlocProvider<HomeCubit>(create: (_) => getIt<HomeCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cat Tinder',
        home: const HomeScreen(),
      ),
    );
  }
}
