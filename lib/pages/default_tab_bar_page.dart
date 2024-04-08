import 'package:flutter/material.dart';
import 'package:mr_hotel/pages/profile_page.dart';
import 'package:mr_hotel/pages/transakasi_page.dart';
import '../common/constant.dart';
import 'dashboard_page.dart';

class DefaultTabBarPage extends StatefulWidget {
  const DefaultTabBarPage({super.key});

  @override
  State<DefaultTabBarPage> createState() => _DefaultTabBarPageState();
}

class _DefaultTabBarPageState extends State<DefaultTabBarPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Mr. Hotel",
          style: primaryTextStyle.copyWith(
            color: primaryColor,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          labelStyle: secondaryTextStyle,
          tabs: const [
            Tab(text: "Beranda"),
            Tab(text: "Riwayat"),
            Tab(text: "Profil"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DashboardPage(),
          TransaksiPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
