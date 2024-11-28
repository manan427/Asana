import '../database.dart';

class UserTasksView2Table extends SupabaseTable<UserTasksView2Row> {
  @override
  String get tableName => 'user_tasks_view2';

  @override
  UserTasksView2Row createRow(Map<String, dynamic> data) =>
      UserTasksView2Row(data);
}

class UserTasksView2Row extends SupabaseDataRow {
  UserTasksView2Row(super.data);

  @override
  SupabaseTable get table => UserTasksView2Table();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  int? get taskId => getField<int>('task_id');
  set taskId(int? value) => setField<int>('task_id', value);

  String? get taskname => getField<String>('taskname');
  set taskname(String? value) => setField<String>('taskname', value);

  String? get roleName => getField<String>('role_name');
  set roleName(String? value) => setField<String>('role_name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get statusId => getField<int>('status_id');
  set statusId(int? value) => setField<int>('status_id', value);

  String? get assignedTo => getField<String>('assigned_to');
  set assignedTo(String? value) => setField<String>('assigned_to', value);

  String? get duedate => getField<String>('duedate');
  set duedate(String? value) => setField<String>('duedate', value);

  String? get enddate => getField<String>('enddate');
  set enddate(String? value) => setField<String>('enddate', value);

  List<String> get collaborator => getListField<String>('collaborator');
  set collaborator(List<String>? value) =>
      setListField<String>('collaborator', value);

  String? get userName => getField<String>('user_name');
  set userName(String? value) => setField<String>('user_name', value);

  String? get repeatative => getField<String>('repeatative');
  set repeatative(String? value) => setField<String>('repeatative', value);

  String? get repeatativeDayMonth => getField<String>('repeatative_day_month');
  set repeatativeDayMonth(String? value) =>
      setField<String>('repeatative_day_month', value);
}
