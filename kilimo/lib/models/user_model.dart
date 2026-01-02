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
  // Location & Farm Details
  final String? district;
  final String? village;
  final double? latitude;
  final double? longitude;
  final double? farmSize;
  final String? farmAddress;
  final String? soilType;
  final String? climateZone;
  // Farming Experience
  final int? farmingExperienceYears;
  final List<String>? primaryCrops;
  final String? farmingMethods;
  final List<String>? equipmentOwned;
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
    this.district,
    this.village,
    this.latitude,
    this.longitude,
    this.farmSize,
    this.farmAddress,
    this.soilType,
    this.climateZone,
    this.farmingExperienceYears,
    this.primaryCrops,
    this.farmingMethods,
    this.equipmentOwned,
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

  // Create from Firestore document
  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      fullName: data['fullName'],
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      phoneNumber: data['phoneNumber'],
      dateOfBirth: data['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['dateOfBirth'])
          : null,
      gender: data['gender'],
      country: data['country'],
      region: data['region'],
      district: data['district'],
      village: data['village'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      farmSize: data['farmSize'],
      farmAddress: data['farmAddress'],
      soilType: data['soilType'],
      climateZone: data['climateZone'],
      farmingExperienceYears: data['farmingExperienceYears'],
      primaryCrops: data['primaryCrops'] != null
          ? List<String>.from(data['primaryCrops'])
          : null,
      farmingMethods: data['farmingMethods'],
      equipmentOwned: data['equipmentOwned'] != null
          ? List<String>.from(data['equipmentOwned'])
          : null,
      createdAt: data['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'])
          : null,
      updatedAt: data['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['updatedAt'])
          : null,
    );
  }

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'gender': gender,
      'country': country,
      'region': region,
      'district': district,
      'village': village,
      'latitude': latitude,
      'longitude': longitude,
      'farmSize': farmSize,
      'farmAddress': farmAddress,
      'soilType': soilType,
      'climateZone': climateZone,
      'farmingExperienceYears': farmingExperienceYears,
      'primaryCrops': primaryCrops,
      'farmingMethods': farmingMethods,
      'equipmentOwned': equipmentOwned,
      'createdAt':
          createdAt?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
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
    String? district,
    String? village,
    double? latitude,
    double? longitude,
    double? farmSize,
    String? farmAddress,
    String? soilType,
    String? climateZone,
    int? farmingExperienceYears,
    List<String>? primaryCrops,
    String? farmingMethods,
    List<String>? equipmentOwned,
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
      district: district ?? this.district,
      village: village ?? this.village,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      farmSize: farmSize ?? this.farmSize,
      farmAddress: farmAddress ?? this.farmAddress,
      soilType: soilType ?? this.soilType,
      climateZone: climateZone ?? this.climateZone,
      farmingExperienceYears:
          farmingExperienceYears ?? this.farmingExperienceYears,
      primaryCrops: primaryCrops ?? this.primaryCrops,
      farmingMethods: farmingMethods ?? this.farmingMethods,
      equipmentOwned: equipmentOwned ?? this.equipmentOwned,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
