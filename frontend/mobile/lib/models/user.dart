class User {
  final int? id;
  final String? img; 
  final String? firstname; 
  final String? lastname; 
  final String? name; 
  final String? birth; 
  final String? email; 
  final String? phone; 
  final String? job_title;

  User({
    required this.id,
    this.img, 
    this.firstname,
    this.lastname,
    this.name,
    this.birth,
    this.email,
    this.phone,
    this.job_title
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      img: json['img'] ?? '',
      firstname: json['firstname'] ?? '', 
      lastname: json['lastname'] ?? '',
      name: json['name'] ?? '', 
      birth: _formatBirthDate(json['birth']),
      email: json['email'] ?? '', 
      phone: json['phone'] ?? '', 
      job_title: json['job_title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'firstname': firstname,
      'lastname': lastname,
      'name': name,
      'birth': birth, 
      'email': email,
      'phone': phone,
      'job_title': job_title
    };
  }

  static String? _formatBirthDate(String? birth) {
    if (birth == null || birth.isEmpty) {
      return null;
    }
    try {
      final parts = birth.split('-'); 
      if (parts.length != 3) {
        return birth; 
      }
      final year = parts[0];  
      final month = parts[1]; 
      final day = parts[2];  
      return '$day $month $year'; 
    } 
    catch (e) {
      return birth; 
    }
  }
}
