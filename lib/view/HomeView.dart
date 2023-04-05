import 'package:flutter/material.dart';
import 'package:msg_basic/helper/ScreenRoutes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msg_basic/view/ConversationTab.dart';
import 'package:msg_basic/view/ContactTab.dart';
import 'package:msg_basic/viewmodel/AuthUserViewModel.dart';
import 'package:msg_basic/viewmodel/HomeViewModel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  late AuthUserViewModel _authUserViewModel;
  late HomeViewModel _homeViewModel;
  final List<String> _menuItems = <String>[AppStrings.menuItemProfile, AppStrings.menuItemLogout];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _authUserViewModel.checkLoggedUser();
      if(_authUserViewModel.currentUser!=null){
        await _homeViewModel.getUserData(_authUserViewModel.currentUser!.id!);
        await _homeViewModel.getAllContacts();
        await _homeViewModel.getAllConversation(_homeViewModel.userData!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    _authUserViewModel = Provider.of<AuthUserViewModel>(context);
    _homeViewModel = Provider.of<HomeViewModel>(context);

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

      body: Observer(
          builder: (_){
            return (_homeViewModel.userData == null)
                ? const Center(child: CircularProgressIndicator(),)
                : TabBarView(
                controller: _tabController,
                children: [
                  ConversationTab(conversations: _homeViewModel.listConversation, onTap: _openConversetion,),
                  ContactTab(
                      contacts: _homeViewModel.listContacts,
                      onTap: _openConversetion
                  )
                ]);
          }
      )
    );
  }

  _selectedMenuItem(String selectedItem) async {
    switch (selectedItem) {
      case AppStrings.menuItemProfile:
        Navigator.pushNamed(context, ScreenRoutes.USER_PROFILE);
        break;
      case AppStrings.menuItemLogout:
        await _authUserViewModel.logout();
        Navigator.pushReplacementNamed(context, ScreenRoutes.LOGIN_ROUTE);
        break;
    }
  }

  _openConversetion(AppUser recipient) async {
    Navigator.pushNamed(
        context,
        ScreenRoutes.CONVERSATION_ROUTE,
        arguments: {"recipient": recipient, "sender": _homeViewModel.userData});
  }
}
