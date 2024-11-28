// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TasksStruct extends BaseStruct {
  TasksStruct({
    int? taskId,
    String? taskname,
    String? duedate,
    String? description,
    String? repeatative,
    String? enddate,
    int? statusId,
    String? assignedTo,
    String? repeatativeDayMonth,
    String? userName,
    String? comments,
    String? attachments,
    List<String>? collaborator,
    String? userId,
    String? date,
  })  : _taskId = taskId,
        _taskname = taskname,
        _duedate = duedate,
        _description = description,
        _repeatative = repeatative,
        _enddate = enddate,
        _statusId = statusId,
        _assignedTo = assignedTo,
        _repeatativeDayMonth = repeatativeDayMonth,
        _userName = userName,
        _comments = comments,
        _attachments = attachments,
        _collaborator = collaborator,
        _userId = userId,
        _date = date;

  // "task_id" field.
  int? _taskId;
  int get taskId => _taskId ?? 0;
  set taskId(int? val) => _taskId = val;

  void incrementTaskId(int amount) => taskId = taskId + amount;

  bool hasTaskId() => _taskId != null;

  // "taskname" field.
  String? _taskname;
  String get taskname => _taskname ?? '';
  set taskname(String? val) => _taskname = val;

  bool hasTaskname() => _taskname != null;

  // "duedate" field.
  String? _duedate;
  String get duedate => _duedate ?? '';
  set duedate(String? val) => _duedate = val;

  bool hasDuedate() => _duedate != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "repeatative" field.
  String? _repeatative;
  String get repeatative => _repeatative ?? '';
  set repeatative(String? val) => _repeatative = val;

  bool hasRepeatative() => _repeatative != null;

  // "enddate" field.
  String? _enddate;
  String get enddate => _enddate ?? '';
  set enddate(String? val) => _enddate = val;

  bool hasEnddate() => _enddate != null;

  // "status_id" field.
  int? _statusId;
  int get statusId => _statusId ?? 0;
  set statusId(int? val) => _statusId = val;

  void incrementStatusId(int amount) => statusId = statusId + amount;

  bool hasStatusId() => _statusId != null;

  // "assigned_to" field.
  String? _assignedTo;
  String get assignedTo => _assignedTo ?? '';
  set assignedTo(String? val) => _assignedTo = val;

  bool hasAssignedTo() => _assignedTo != null;

  // "repeatative_day_month" field.
  String? _repeatativeDayMonth;
  String get repeatativeDayMonth => _repeatativeDayMonth ?? '';
  set repeatativeDayMonth(String? val) => _repeatativeDayMonth = val;

  bool hasRepeatativeDayMonth() => _repeatativeDayMonth != null;

  // "user_name" field.
  String? _userName;
  String get userName => _userName ?? '';
  set userName(String? val) => _userName = val;

  bool hasUserName() => _userName != null;

  // "comments" field.
  String? _comments;
  String get comments => _comments ?? '';
  set comments(String? val) => _comments = val;

  bool hasComments() => _comments != null;

  // "attachments" field.
  String? _attachments;
  String get attachments => _attachments ?? '';
  set attachments(String? val) => _attachments = val;

  bool hasAttachments() => _attachments != null;

  // "collaborator" field.
  List<String>? _collaborator;
  List<String> get collaborator => _collaborator ?? const [];
  set collaborator(List<String>? val) => _collaborator = val;

  void updateCollaborator(Function(List<String>) updateFn) {
    updateFn(_collaborator ??= []);
  }

  bool hasCollaborator() => _collaborator != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  static TasksStruct fromMap(Map<String, dynamic> data) => TasksStruct(
        taskId: castToType<int>(data['task_id']),
        taskname: data['taskname'] as String?,
        duedate: data['duedate'] as String?,
        description: data['description'] as String?,
        repeatative: data['repeatative'] as String?,
        enddate: data['enddate'] as String?,
        statusId: castToType<int>(data['status_id']),
        assignedTo: data['assigned_to'] as String?,
        repeatativeDayMonth: data['repeatative_day_month'] as String?,
        userName: data['user_name'] as String?,
        comments: data['comments'] as String?,
        attachments: data['attachments'] as String?,
        collaborator: getDataList(data['collaborator']),
        userId: data['user_id'] as String?,
        date: data['date'] as String?,
      );

  static TasksStruct? maybeFromMap(dynamic data) =>
      data is Map ? TasksStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'task_id': _taskId,
        'taskname': _taskname,
        'duedate': _duedate,
        'description': _description,
        'repeatative': _repeatative,
        'enddate': _enddate,
        'status_id': _statusId,
        'assigned_to': _assignedTo,
        'repeatative_day_month': _repeatativeDayMonth,
        'user_name': _userName,
        'comments': _comments,
        'attachments': _attachments,
        'collaborator': _collaborator,
        'user_id': _userId,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'task_id': serializeParam(
          _taskId,
          ParamType.int,
        ),
        'taskname': serializeParam(
          _taskname,
          ParamType.String,
        ),
        'duedate': serializeParam(
          _duedate,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'repeatative': serializeParam(
          _repeatative,
          ParamType.String,
        ),
        'enddate': serializeParam(
          _enddate,
          ParamType.String,
        ),
        'status_id': serializeParam(
          _statusId,
          ParamType.int,
        ),
        'assigned_to': serializeParam(
          _assignedTo,
          ParamType.String,
        ),
        'repeatative_day_month': serializeParam(
          _repeatativeDayMonth,
          ParamType.String,
        ),
        'user_name': serializeParam(
          _userName,
          ParamType.String,
        ),
        'comments': serializeParam(
          _comments,
          ParamType.String,
        ),
        'attachments': serializeParam(
          _attachments,
          ParamType.String,
        ),
        'collaborator': serializeParam(
          _collaborator,
          ParamType.String,
          isList: true,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
      }.withoutNulls;

  static TasksStruct fromSerializableMap(Map<String, dynamic> data) =>
      TasksStruct(
        taskId: deserializeParam(
          data['task_id'],
          ParamType.int,
          false,
        ),
        taskname: deserializeParam(
          data['taskname'],
          ParamType.String,
          false,
        ),
        duedate: deserializeParam(
          data['duedate'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        repeatative: deserializeParam(
          data['repeatative'],
          ParamType.String,
          false,
        ),
        enddate: deserializeParam(
          data['enddate'],
          ParamType.String,
          false,
        ),
        statusId: deserializeParam(
          data['status_id'],
          ParamType.int,
          false,
        ),
        assignedTo: deserializeParam(
          data['assigned_to'],
          ParamType.String,
          false,
        ),
        repeatativeDayMonth: deserializeParam(
          data['repeatative_day_month'],
          ParamType.String,
          false,
        ),
        userName: deserializeParam(
          data['user_name'],
          ParamType.String,
          false,
        ),
        comments: deserializeParam(
          data['comments'],
          ParamType.String,
          false,
        ),
        attachments: deserializeParam(
          data['attachments'],
          ParamType.String,
          false,
        ),
        collaborator: deserializeParam<String>(
          data['collaborator'],
          ParamType.String,
          true,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TasksStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TasksStruct &&
        taskId == other.taskId &&
        taskname == other.taskname &&
        duedate == other.duedate &&
        description == other.description &&
        repeatative == other.repeatative &&
        enddate == other.enddate &&
        statusId == other.statusId &&
        assignedTo == other.assignedTo &&
        repeatativeDayMonth == other.repeatativeDayMonth &&
        userName == other.userName &&
        comments == other.comments &&
        attachments == other.attachments &&
        listEquality.equals(collaborator, other.collaborator) &&
        userId == other.userId &&
        date == other.date;
  }

  @override
  int get hashCode => const ListEquality().hash([
        taskId,
        taskname,
        duedate,
        description,
        repeatative,
        enddate,
        statusId,
        assignedTo,
        repeatativeDayMonth,
        userName,
        comments,
        attachments,
        collaborator,
        userId,
        date
      ]);
}

TasksStruct createTasksStruct({
  int? taskId,
  String? taskname,
  String? duedate,
  String? description,
  String? repeatative,
  String? enddate,
  int? statusId,
  String? assignedTo,
  String? repeatativeDayMonth,
  String? userName,
  String? comments,
  String? attachments,
  String? userId,
  String? date,
}) =>
    TasksStruct(
      taskId: taskId,
      taskname: taskname,
      duedate: duedate,
      description: description,
      repeatative: repeatative,
      enddate: enddate,
      statusId: statusId,
      assignedTo: assignedTo,
      repeatativeDayMonth: repeatativeDayMonth,
      userName: userName,
      comments: comments,
      attachments: attachments,
      userId: userId,
      date: date,
    );
