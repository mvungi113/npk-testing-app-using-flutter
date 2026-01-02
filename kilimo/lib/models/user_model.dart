class UserModel {
  final String uid;
  final String? fullName;
  final String email;
  final String? profileImageUrl;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? country;
  final String? region;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    this.fullName,
    required this.email,
    this.profileImageUrl,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.country,
    this.region,
    this.createdAt,
    this.updatedAt,
  });

  // Calculate age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  // Check if profile is complete (has basic required information)
  bool get isProfileComplete {
    return fullName != null && fullName!.isNotEmpty;
  }

  // Create from Supabase document
  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      fullName: data['full_name'],
      email: data['email'] ?? '',
      profileImageUrl: data['profile_image_url'],
      phoneNumber: data['phone_number'],
      dateOfBirth: data['date_of_birth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['date_of_birth'])
          : null,
      gender: data['gender'],
      country: data['country'],
      region: data['region'],
      createdAt: data['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['created_at'])
          : null,
      updatedAt: data['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['updated_at'])
          : null,
    );
  }

  // Convert to map for Supabase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'profile_image_url': profileImageUrl,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth?.millisecondsSinceEpoch,
      'gender': gender,
      'country': country,
      'region': region,
      'created_at':
          createdAt?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    };
  }

  // Copy with method for updates
  UserModel copyWith({
    String? fullName,
    String? profileImageUrl,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? country,
    String? region,
  }) {
    return UserModel(
      uid: uid,
      fullName: fullName ?? this.fullName,
      email: email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      region: region ?? this.region,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
