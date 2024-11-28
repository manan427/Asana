import '../database.dart';

class UserRoleCounts2Table extends SupabaseTable<UserRoleCounts2Row> {
  @override
  String get tableName => 'user_role_counts2';

  @override
  UserRoleCounts2Row createRow(Map<String, dynamic> data) =>
      UserRoleCounts2Row(data);
}

class UserRoleCounts2Row extends SupabaseDataRow {
  UserRoleCounts2Row(super.data);

  @override
  SupabaseTable get table => UserRoleCounts2Table();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  int? get assignorCount => getField<int>('assignor_count');
  set assignorCount(int? value) => setField<int>('assignor_count', value);

  int? get assigneeCount => getField<int>('assignee_count');
  set assigneeCount(int? value) => setField<int>('assignee_count', value);

  int? get followerCount => getField<int>('follower_count');
  set followerCount(int? value) => setField<int>('follower_count', value);

  int? get statusid1Count => getField<int>('statusid1_count');
  set statusid1Count(int? value) => setField<int>('statusid1_count', value);

  int? get statusid2Count => getField<int>('statusid2_count');
  set statusid2Count(int? value) => setField<int>('statusid2_count', value);
}
