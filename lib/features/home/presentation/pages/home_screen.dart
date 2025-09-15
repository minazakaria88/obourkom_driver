import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obourkom_driver/core/helpers/check_internet_class.dart';
import 'package:obourkom_driver/features/home/presentation/cubit/home_cubit.dart';
import '../../../../core/widgets/bottom_app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CheckInternetClass.checkInternetStream();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      CheckInternetClass.dispose();
    } else if (state == AppLifecycleState.resumed) {
      CheckInternetClass.checkInternetStream();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    CheckInternetClass.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


   List<String> titles = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: state.currentIndex == 0
              ? null
              : AppBar(
                  bottom: const BottomAppBarWidget(),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(cubit.titles(context)[state.currentIndex]),
                ),
          bottomNavigationBar: MyBottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
       //cubit.screens[state.currentIndex],
          body:
              cubit.screens[state.currentIndex],

        );

      },
    );
  }
}
