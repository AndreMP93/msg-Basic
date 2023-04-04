import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msg_basic/helper/GetImage.dart';
import 'package:msg_basic/helper/ScreenRoutes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/resources/AppColors.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:msg_basic/viewmodel/AuthUserViewModel.dart';
import 'package:msg_basic/viewmodel/UserProfileViewModel.dart';
import 'package:msg_basic/widget/CustomAlertDialogForEditData.dart';
import 'package:msg_basic/widget/CustomInputTextForAlertDialog.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {

  late AuthUserViewModel _authUserViewModel;
  late UserProfileViewModel _userProfileViewModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _authUserViewModel.checkLoggedUser();
      AppUser? user = _authUserViewModel.currentUser;
      if(user != null){
        await _userProfileViewModel.getUser(user);
        user = _userProfileViewModel.userData;
        if(user!=null){
          _nameController.text = user.name!;
          _aboutController.text = user.about;
        }
      }else{
        Navigator.pushReplacementNamed(context, ScreenRoutes.LOGIN_ROUTE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    _authUserViewModel = Provider.of<AuthUserViewModel>(context);
    _userProfileViewModel = Provider.of<UserProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.userProfileLabel),),
      body: Observer(builder: (_){
        return (_userProfileViewModel.userData == null)
        ? Center(child: CircularProgressIndicator(),)
        :Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        if(!_userProfileViewModel.uploadingImage){
                          _editProfilePicture(context);
                        }
                      },
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(_userProfileViewModel.userData!.urlProfilePicture),
                        child: (_userProfileViewModel.uploadingImage)
                            ?Center(child: CircularProgressIndicator())
                            :null,
                      )
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.person, color: AppColors.primaryColor, size: 32,),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text(
                                AppStrings.userNameLabel,
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ),
                            Text(_nameController.text,
                                style: const TextStyle(color: Colors.black, fontSize: 20)
                            )
                          ],
                        ),
                      ),
                      //const Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: GestureDetector(
                              child: const Icon(Icons.edit, color: AppColors.primaryColor, size: 32,),
                              onTap: () async {
                                await _editUserName(context);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.info_outline, color: AppColors.primaryColor, size: 32,),
                      ),
                      Expanded(
                        // flex: 5,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text(
                                AppStrings.aboutLabel,
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ),
                            Text(_aboutController.text, style: const TextStyle(color: Colors.black, fontSize: 20))
                          ],
                        ),
                      ),
                      // const Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: GestureDetector(
                              child: const Icon(Icons.edit, color:AppColors.primaryColor, size: 32,),
                              onTap: () async {
                                await _editAbout(context);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.email, color: AppColors.primaryColor, size: 32,),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  AppStrings.emailLabel,
                                  style: TextStyle(color: Colors.grey, fontSize: 18),
                                ),
                              ),
                              Text(_userProfileViewModel.userData!.email!,
                                  style: const TextStyle(color: Colors.black, fontSize: 20)
                              )
                            ],
                          )
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _editProfilePicture(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Foto do Perfil"),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt, color: AppColors.primaryColor, size: 40,),
                onPressed: () async {
                  var foto = await GetImage.fromCamera();
                  if (foto != null) {
                    Navigator.of(context).pop();
                    _userProfileViewModel.updateProfilePhoto(foto, _userProfileViewModel.userData!);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(icon: const Icon(Icons.photo, color: AppColors.primaryColor, size: 40,),
                  onPressed: () async {
                    var foto = await GetImage.fromGallery();
                    if (foto != null) {
                      Navigator.of(context).pop();
                      _userProfileViewModel.updateProfilePhoto(foto, _userProfileViewModel.userData!);
                    }
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<void> _editUserName(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext _){
          return CustomAlertDialogForEditData(
              title: const Text(AppStrings.editNameTitle),
              formKey: formKey,
              inputTextWidget: CustomInputTextForAlertDialog( formKey: formKey,  controller: _nameController),
              updateAdFunction: ()async{
                _userProfileViewModel.userData!.name = _nameController.text;
                await _userProfileViewModel.updateUserData(_userProfileViewModel.userData!);
                // Navigator.of(context).pop();
              }
          );
        }
    );
  }

  Future<void> _editAbout(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext _){
          return CustomAlertDialogForEditData(
              title: const Text(AppStrings.editAboutTitle),
              formKey: formKey,
              inputTextWidget: CustomInputTextForAlertDialog( formKey: formKey,  controller: _aboutController),
              updateAdFunction: ()async{
                _userProfileViewModel.userData!.about = _aboutController.text;
                await _userProfileViewModel.updateUserData(_userProfileViewModel.userData!);
                // Navigator.of(context).pop();
              }
          );
        }
    );
  }
}


