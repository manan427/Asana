// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRolesStruct extends BaseStruct {
  UserRolesStruct({
    int? id,
    String? userId,
    int? roleId,
    int? taskId,
  })  : _id = id,
        _userId = userId,
        _roleId = roleId,
        _taskId = taskId;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "role_id" field.
  int? _roleId;
  int get roleId => _roleId ?? 0;
  set roleId(int? val) => _roleId = val;

  void incrementRoleId(int amount) => roleId = roleId + amount;

  bool hasRoleId() => _roleId != null;

  // "task_id" field.
  int? _taskId;
  int get taskId => _taskId ?? 0;
  set taskId(int? val) => _taskId = val;

  void incrementTaskId(int amount) => taskId = taskId + amount;

  bool hasTaskId() => _taskId != null;

  static UserRolesStruct fromMap(Map<String, dynamic> data) => UserRolesStruct(
        id: castToType<int>(data['id']),
        userId: data['user_id'] as String?,
        roleId: castToType<int>(data['role_id']),
        taskId: castToType<int>(data['task_id']),
      );

  static UserRolesStruct? maybeFromMap(dynamic data) => data is Map
      ? UserRolesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'user_id': _userId,
        'role_id': _roleId,
        'task_id': _taskId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'role_id': serializeParam(
          _roleId,
          ParamType.int,
        ),
        'task_id': serializeParam(
          _taskId,
          ParamType.int,
        ),
      }.withoutNulls;

  static UserRolesStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserRolesStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        roleId: deserializeParam(
          data['role_id'],
          ParamType.int,
          false,
        ),
        taskId: deserializeParam(
          data['task_id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UserRolesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserRolesStruct &&
        id == other.id &&
        userId == other.userId &&
        roleId == other.roleId &&
        taskId == other.taskId;
  }

  @override
  int get hashCode => const ListEquality().hash([id, userId, roleId, taskId]);
}

UserRolesStruct createUserRolesStruct({
  int? id,
  String? userId,
  int? roleId,
  int? taskId,
}) =>
    UserRolesStruct(
      id: id,
      userId: userId,
      roleId: roleId,
      taskId: taskId,
    );
