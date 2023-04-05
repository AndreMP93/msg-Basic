import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/helper/ScreenRoutes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/viewmodel/HomeViewModel.dart';

class ContactTab extends StatefulWidget {
  final ObservableList<AppUser> contacts;
  final Function(AppUser) onTap;
  const ContactTab({required this.contacts, required this.onTap, Key? key}) : super(key: key);

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {

  @override
  Widget build(BuildContext context) {

    return Observer(
        builder: (_){
          return Container(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: widget.contacts.length,
                itemBuilder: (context, index){
                  AppUser contact = widget.contacts[index];
                  return Container(
                    // padding: const EdgeInsets.only(top: 5),
                    child: ListTile(
                      title: Text(contact.name??"", maxLines: 1, style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      subtitle: Text(contact.about, maxLines: 1,),
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(contact.urlProfilePicture)
                      ),
                      onTap: (){
                        widget.onTap(contact);
                      },
                    ),
                  );
                }
            ),
          );
        }
    );
  }
}
