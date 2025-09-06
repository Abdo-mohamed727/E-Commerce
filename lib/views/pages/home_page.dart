import 'package:flutter/material.dart';

import 'package:ecommerce_new/widgets/Category_tabview.dart';
import 'package:ecommerce_new/widgets/home_tabbar_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              labelColor: Theme.of(context).colorScheme.primary,
              controller: _tabController,
              tabs: const [
                Tab(text: "Home"),
                Tab(text: "Category"),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  HomeTabview(),
                  CategoryTabview(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
