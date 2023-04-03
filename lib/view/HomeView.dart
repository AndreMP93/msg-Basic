import 'package:flutter/material.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:msg_basic/view/ConversationTab.dart';
import 'package:msg_basic/view/ContactTab.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  bool _isUserLogged = true;
  final List<String> _menuItems = <String>[AppStrings.menuItemProfile, AppStrings.menuItemLogout];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          PopupMenuButton<String>(
            onSelected: _selectedMenuItem,
            itemBuilder: (context) {
              return _menuItems.map((String item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelStyle:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            tabs: const <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(AppStrings.tabConversationsLabel),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(AppStrings.tabContactsLabel),
              )
          ])
      ),

      body: (!_isUserLogged)
          ? Center(child: CircularProgressIndicator(),)
          : TabBarView(
          controller: _tabController,
          children: [
            ConversationTab(),
            ContactTab()
          ]),
    );
  }

  _selectedMenuItem(String selectedItem) async {
    switch (selectedItem) {
      case AppStrings.menuItemProfile:
        break;
      case AppStrings.menuItemLogout:
        break;
    }
  }
}
