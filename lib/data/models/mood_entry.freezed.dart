// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MoodEntryModel _$MoodEntryModelFromJson(Map<String, dynamic> json) {
  return _MoodEntryModel.fromJson(json);
}

/// @nodoc
mixin _$MoodEntryModel {
  String get id => throw _privateConstructorUsedError;
  MoodType get mood => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this MoodEntryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MoodEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MoodEntryModelCopyWith<MoodEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodEntryModelCopyWith<$Res> {
  factory $MoodEntryModelCopyWith(
          MoodEntryModel value, $Res Function(MoodEntryModel) then) =
      _$MoodEntryModelCopyWithImpl<$Res, MoodEntryModel>;
  @useResult
  $Res call({String id, MoodType mood, DateTime timestamp, String? note});
}

/// @nodoc
class _$MoodEntryModelCopyWithImpl<$Res, $Val extends MoodEntryModel>
    implements $MoodEntryModelCopyWith<$Res> {
  _$MoodEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoodEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mood = null,
    Object? timestamp = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as MoodType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoodEntryModelImplCopyWith<$Res>
    implements $MoodEntryModelCopyWith<$Res> {
  factory _$$MoodEntryModelImplCopyWith(_$MoodEntryModelImpl value,
          $Res Function(_$MoodEntryModelImpl) then) =
      __$$MoodEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, MoodType mood, DateTime timestamp, String? note});
}

/// @nodoc
class __$$MoodEntryModelImplCopyWithImpl<$Res>
    extends _$MoodEntryModelCopyWithImpl<$Res, _$MoodEntryModelImpl>
    implements _$$MoodEntryModelImplCopyWith<$Res> {
  __$$MoodEntryModelImplCopyWithImpl(
      _$MoodEntryModelImpl _value, $Res Function(_$MoodEntryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoodEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mood = null,
    Object? timestamp = null,
    Object? note = freezed,
  }) {
    return _then(_$MoodEntryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as MoodType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoodEntryModelImpl extends _MoodEntryModel {
  const _$MoodEntryModelImpl(
      {required this.id,
      required this.mood,
      required this.timestamp,
      this.note})
      : super._();

  factory _$MoodEntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoodEntryModelImplFromJson(json);

  @override
  final String id;
  @override
  final MoodType mood;
  @override
  final DateTime timestamp;
  @override
  final String? note;

  @override
  String toString() {
    return 'MoodEntryModel(id: $id, mood: $mood, timestamp: $timestamp, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodEntryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mood, mood) || other.mood == mood) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, mood, timestamp, note);

  /// Create a copy of MoodEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodEntryModelImplCopyWith<_$MoodEntryModelImpl> get copyWith =>
      __$$MoodEntryModelImplCopyWithImpl<_$MoodEntryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoodEntryModelImplToJson(
      this,
    );
  }
}

abstract class _MoodEntryModel extends MoodEntryModel {
  const factory _MoodEntryModel(
      {required final String id,
      required final MoodType mood,
      required final DateTime timestamp,
      final String? note}) = _$MoodEntryModelImpl;
  const _MoodEntryModel._() : super._();

  factory _MoodEntryModel.fromJson(Map<String, dynamic> json) =
      _$MoodEntryModelImpl.fromJson;

  @override
  String get id;
  @override
  MoodType get mood;
  @override
  DateTime get timestamp;
  @override
  String? get note;

  /// Create a copy of MoodEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoodEntryModelImplCopyWith<_$MoodEntryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
