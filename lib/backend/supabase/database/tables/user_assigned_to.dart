import '../database.dart';

class UserAssignedToTable extends SupabaseTable<UserAssignedToRow> {
  @override
  String get tableName => 'user_assignedTo';

  @override
  UserAssignedToRow createRow(Map<String, dynamic> data) =>
      UserAssignedToRow(data);
}

class UserAssignedToRow extends SupabaseDataRow {
  UserAssignedToRow(super.data);

  @override
  SupabaseTable get table => UserAssignedToTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  int? get taskId => getField<int>('task_id');
  set taskId(int? value) => setField<int>('task_id', value);

  int? get roleId => getField<int>('role_id');
  set roleId(int? value) => setField<int>('role_id', value);
}
