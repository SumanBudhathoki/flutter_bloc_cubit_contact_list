class ContactModel {
  int? id;
  String name;
  String phoneNumber;
  final String? avatarUrl;

  ContactModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    this.avatarUrl,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      avatarUrl: map['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
    };
  }
}
