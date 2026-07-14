import 'package:hive/hive.dart';

part 'profile_model_hive.g.dart';

@HiveType(typeId: 3)
class ProfileModelHive extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String name;

  @HiveField(2)
  String address;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String pinCode;

  @HiveField(5)
  String? imagePath; // path of saved photo

  ProfileModelHive({
    required this.email,
    required this.name,
    required this.address,
    required this.phone,
    required this.pinCode,
    this.imagePath,
  });
}
