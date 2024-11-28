import '../database.dart';

class TasksTable extends SupabaseTable<TasksRow> {
  @override
  String get tableName => 'tasks';

  @override
  TasksRow createRow(Map<String, dynamic> data) => TasksRow(data);
}

class TasksRow extends SupabaseDataRow {
  TasksRow(super.data);

  @override
  SupabaseTable get table => TasksTable();

  int get taskId => getField<int>('task_id')!;
  set taskId(int value) => setField<int>('task_id', value);

  String? get taskname => getField<String>('taskname');
  set taskname(String? value) => setField<String>('taskname', value);

  String? get duedate => getField<String>('duedate');
  set duedate(String? value) => setField<String>('duedate', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get repeatative => getField<String>('repeatative');
  set repeatative(String? value) => setField<String>('repeatative', value);

  String? get enddate => getField<String>('enddate');
  set enddate(String? value) => setField<String>('enddate', value);

  int? get statusId => getField<int>('status_id');
  set statusId(int? value) => setField<int>('status_id', value);

  String? get assignedTo => getField<String>('assigned_to');
  set assignedTo(String? value) => setField<String>('assigned_to', value);

  String? get repeatativeDayMonth => getField<String>('repeatative_day_month');
  set repeatativeDayMonth(String? value) =>
      setField<String>('repeatative_day_month', value);

  String? get userName => getField<String>('user_name');
  set userName(String? value) => setField<String>('user_name', value);

  String? get comments => getField<String>('comments');
  set comments(String? value) => setField<String>('comments', value);

  String? get attachments => getField<String>('attachments');
  set attachments(String? value) => setField<String>('attachments', value);

  List<String> get collaborator => getListField<String>('collaborator');
  set collaborator(List<String>? value) =>
      setListField<String>('collaborator', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get date => getField<String>('date');
  set date(String? value) => setField<String>('date', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get monthlyWeek => getField<String>('monthly_week');
  set monthlyWeek(String? value) => setField<String>('monthly_week', value);

  String? get monthlyDay => getField<String>('monthly_day');
  set monthlyDay(String? value) => setField<String>('monthly_day', value);

  String? get monthlyDate => getField<String>('monthly_date');
  set monthlyDate(String? value) => setField<String>('monthly_date', value);

  String? get tags => getField<String>('tags');
  set tags(String? value) => setField<String>('tags', value);

  String? get project => getField<String>('project');
  set project(String? value) => setField<String>('project', value);
}
