import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/app/presentation/controllers/home_controller.dart';
import 'package:my_note/app/presentation/views/network_note_page.dart';
import 'package:my_note/app/presentation/views/saved_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Note App'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              child: Text(
                'Note',
              ),
            ),
            Tab(
              child: Text(
                'Saved',
              ),
            ),
          ],
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 4,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          NetworkNotePage(),
          SavedNotePage(),
        ],
      ),
    );
  }
}
