import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart'; 
import 'dart:io';

// Model 
import 'package:mobile/models/user.dart';

// Service
import 'package:mobile/services/user_service.dart'; 
import 'package:mobile/services/avatar_service.dart';

class AvatarProfile extends StatefulWidget {
  final User user;

  AvatarProfile({required this.user});

  @override
  _AvatarProfileState createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  String? avatarUrl;
  bool isLoading = false;

  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    avatarUrl = getFullAvatarUrl(widget.user.img ?? defaultAvatarUrl);
  }

  Future<void> _updateAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(), 
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(),
            ],
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        final File avatarFile = File(croppedFile.path); 
        try {
          setState(() {
            isLoading = true; 
          });

          final response = await userService.updateAvatar(widget.user.id, avatarFile);
          
          if (response is Map<String, dynamic> && response.containsKey('status')) {
            if (response['status'] == 'success') {
              setState(() {
                avatarUrl = response['img']; 
                widget.user.img = response['img']; 
              });
            } 
            else {
              print("Failed to update avatar: ${response['message']}");
            }
          } 
          else {
            print("Unexpected response format: $response");
          }
        } 
        catch (err) {
          print("Failed to update avatar: $err");
        } 
        finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      context: context, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _updateAvatar(); 
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300]
                      ),
                      child: Icon(Icons.image, size: 20),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Choose image profile from device',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showBottomSheet,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: isLoading
            ? CircularProgressIndicator() 
            : (avatarUrl != null
                ? Image.network(avatarUrl!, width: 100, height: 100, fit: BoxFit.cover)
                : Image.network("https://imgur.com/AhaZ0qB.jpg", width: 100, height: 100)),
      ),
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
