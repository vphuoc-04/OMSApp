// Check default
bool isDefaultAvatar(String? avatar) {
  if (avatar == null) return false; 
  final pattern = RegExp(r'^https?:\/\/', caseSensitive: false); 
  return pattern.hasMatch(avatar); 
}

// Default or new
String getFullAvatarUrl(String path) {
  if (isDefaultAvatar(path)) {
    return path; 
  }
  
  const String backendUrl = "http://10.0.2.2:8000/storage/";
  return "$backendUrl$path";
}

// Avatar default
const String defaultAvatarUrl = "https://imgur.com/AhaZ0qB.jpg";
