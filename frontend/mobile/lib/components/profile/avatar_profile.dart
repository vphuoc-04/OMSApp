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
  bool isConfirmDelete = false;

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
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(), 
            ],
          ),
          IOSUiSettings(
            title: 'Crop Image',
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
              print("Avatar updated successfully: $avatarUrl");
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

  void _showAvatarView() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          child: Container(
            width: 800,
            height: 500,
            child: Image.network(avatarUrl!),
          ),
        );
      },
    );
  }

  Future<void> _deleteAvatar() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await userService.deleteAvatar(widget.user.id);

      if (response is Map<String, dynamic> && response.containsKey('status')) {
        if (response['status'] == 'success') {
          setState(() {
            avatarUrl = defaultAvatarUrl; 
            widget.user.img = defaultAvatarUrl; 
          });
          print("Avatar deleted successfully.");
        } 
        else {
          print("Failed to delete avatar: ${response['message']}");
        }
      } 
      else {
        print("Unexpected response format: $response");
      }
    } 
    catch (err) {
      print("Failed to delete avatar: $err");
    } 
    finally {
      setState(() {
        isLoading = false;
        isConfirmDelete = false; 
      });
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          height: isConfirmDelete ? 120 : (avatarUrl == defaultAvatarUrl ? 68 : 165),
          child: ListView( // Thay đổi thành ListView
            children: [
              if (isConfirmDelete) ...[
                Text(
                  'Are you sure to delete this avatar?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isConfirmDelete = false;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Đóng BottomSheet
                        _deleteAvatar(); // Gọi hàm xóa avatar
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _updateAvatar();
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: Icon(Icons.image, size: 20),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Choose image profile from device',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                if (avatarUrl != null && avatarUrl != defaultAvatarUrl)
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _showAvatarView();
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: Icon(Icons.remove_red_eye, size: 20),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'View avatar',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10),
                if (avatarUrl != null && avatarUrl != defaultAvatarUrl)
                  InkWell(
                    onTap: () {
                      setState(() {
                        isConfirmDelete = true;
                      });
                      Navigator.pop(context);
                      _showBottomSheet(); 
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: Icon(Icons.delete, size: 20),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Delete avatar',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showBottomSheet,
      child: Container(
        width: 100, 
        height: 100, 
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          image: DecorationImage(
            image: NetworkImage(
              avatarUrl != null && avatarUrl != defaultAvatarUrl
                  ? avatarUrl!
                  : defaultAvatarUrl,
            ),
            fit: BoxFit.cover, 
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator()
            : null, 
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
