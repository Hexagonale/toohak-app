import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toohak/_toohak.dart';

class ProfilesDataProvider {
  final FirebaseFirestore _firebaseFirestore = sl();

  Future<Map<String, Profile>> fetchAll() async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firebaseFirestore.collection(Collections.profiles).get();

    final Map<String, Profile> profiles = <String, Profile>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final Profile profile = Profile.fromJson(doc.data()..['id'] = doc.id);
      profiles[doc.id] = profile;
    }

    return profiles;
  }

  Future<Profile?> getWithId(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseFirestore.collection(Collections.profiles).doc(id).get();

    if (!result.exists) {
      return null;
    }

    return Profile.fromJson(result.data()!..[ProfileFields.id] = result.id);
  }

  Future<void> createWithId({
    required String id,
    required ProfileWriteRequest profileWriteRequest,
  }) async {
    await _firebaseFirestore.collection(Collections.profiles).doc(id).set(profileWriteRequest.toJson());
  }

  Future<void> addGameTemplate({
    required String id,
    required String gameTemplateId,
  }) async {
    await _firebaseFirestore.collection(Collections.profiles).doc(id).update(
      <String, dynamic>{
        ProfileFields.gameTemplateIds: FieldValue.arrayUnion(
          [gameTemplateId],
        )
      },
    );
  }
}
