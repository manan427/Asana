import '../database.dart';

class RolesTableTable extends SupabaseTable<RolesTableRow> {
  @override
  String get tableName => 'roles_table';

  @override
  RolesTableRow createRow(Map<String, dynamic> data) => RolesTableRow(data);
}

class RolesTableRow extends SupabaseDataRow {
  RolesTableRow(super.data);

  @override
  SupabaseTable get table => RolesTableTable();

  int get roleId => getField<int>('role_id')!;
  set roleId(int value) => setField<int>('role_id', value);

  String? get roleName => getField<String>('role_name');
  set roleName(String? value) => setField<String>('role_name', value);
}
