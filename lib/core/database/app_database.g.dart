// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RemindersTableTable extends RemindersTable
    with TableInfo<$RemindersTableTable, ReminderRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('BDT'));
  static const VerificationMeta _isRecurringMeta =
      const VerificationMeta('isRecurring');
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
      'is_recurring', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_recurring" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _recurrenceTypeMeta =
      const VerificationMeta('recurrenceType');
  @override
  late final GeneratedColumn<String> recurrenceType = GeneratedColumn<String>(
      'recurrence_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recurrenceIntervalMeta =
      const VerificationMeta('recurrenceInterval');
  @override
  late final GeneratedColumn<int> recurrenceInterval = GeneratedColumn<int>(
      'recurrence_interval', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        title,
        description,
        category,
        dueDate,
        amount,
        currencyCode,
        isRecurring,
        recurrenceType,
        recurrenceInterval,
        isCompleted,
        completedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(Insertable<ReminderRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
          _isRecurringMeta,
          isRecurring.isAcceptableOrUnknown(
              data['is_recurring']!, _isRecurringMeta));
    }
    if (data.containsKey('recurrence_type')) {
      context.handle(
          _recurrenceTypeMeta,
          recurrenceType.isAcceptableOrUnknown(
              data['recurrence_type']!, _recurrenceTypeMeta));
    }
    if (data.containsKey('recurrence_interval')) {
      context.handle(
          _recurrenceIntervalMeta,
          recurrenceInterval.isAcceptableOrUnknown(
              data['recurrence_interval']!, _recurrenceIntervalMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      isRecurring: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_recurring'])!,
      recurrenceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurrence_type']),
      recurrenceInterval: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}recurrence_interval']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RemindersTableTable createAlias(String alias) {
    return $RemindersTableTable(attachedDatabase, alias);
  }
}

class ReminderRecord extends DataClass implements Insertable<ReminderRecord> {
  final int id;
  final String uuid;
  final String title;
  final String? description;

  /// One of: payment, document, subscription, warranty
  final String category;
  final DateTime dueDate;
  final double? amount;
  final String currencyCode;
  final bool isRecurring;

  /// One of: daily, weekly, monthly, yearly — null when not recurring
  final String? recurrenceType;

  /// How many units of recurrenceType between occurrences
  final int? recurrenceInterval;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReminderRecord(
      {required this.id,
      required this.uuid,
      required this.title,
      this.description,
      required this.category,
      required this.dueDate,
      this.amount,
      required this.currencyCode,
      required this.isRecurring,
      this.recurrenceType,
      this.recurrenceInterval,
      required this.isCompleted,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['is_recurring'] = Variable<bool>(isRecurring);
    if (!nullToAbsent || recurrenceType != null) {
      map['recurrence_type'] = Variable<String>(recurrenceType);
    }
    if (!nullToAbsent || recurrenceInterval != null) {
      map['recurrence_interval'] = Variable<int>(recurrenceInterval);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RemindersTableCompanion toCompanion(bool nullToAbsent) {
    return RemindersTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      dueDate: Value(dueDate),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      currencyCode: Value(currencyCode),
      isRecurring: Value(isRecurring),
      recurrenceType: recurrenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceType),
      recurrenceInterval: recurrenceInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceInterval),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReminderRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRecord(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      amount: serializer.fromJson<double?>(json['amount']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      recurrenceType: serializer.fromJson<String?>(json['recurrenceType']),
      recurrenceInterval: serializer.fromJson<int?>(json['recurrenceInterval']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'amount': serializer.toJson<double?>(amount),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'recurrenceType': serializer.toJson<String?>(recurrenceType),
      'recurrenceInterval': serializer.toJson<int?>(recurrenceInterval),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReminderRecord copyWith(
          {int? id,
          String? uuid,
          String? title,
          Value<String?> description = const Value.absent(),
          String? category,
          DateTime? dueDate,
          Value<double?> amount = const Value.absent(),
          String? currencyCode,
          bool? isRecurring,
          Value<String?> recurrenceType = const Value.absent(),
          Value<int?> recurrenceInterval = const Value.absent(),
          bool? isCompleted,
          Value<DateTime?> completedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ReminderRecord(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        category: category ?? this.category,
        dueDate: dueDate ?? this.dueDate,
        amount: amount.present ? amount.value : this.amount,
        currencyCode: currencyCode ?? this.currencyCode,
        isRecurring: isRecurring ?? this.isRecurring,
        recurrenceType:
            recurrenceType.present ? recurrenceType.value : this.recurrenceType,
        recurrenceInterval: recurrenceInterval.present
            ? recurrenceInterval.value
            : this.recurrenceInterval,
        isCompleted: isCompleted ?? this.isCompleted,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ReminderRecord copyWithCompanion(RemindersTableCompanion data) {
    return ReminderRecord(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      isRecurring:
          data.isRecurring.present ? data.isRecurring.value : this.isRecurring,
      recurrenceType: data.recurrenceType.present
          ? data.recurrenceType.value
          : this.recurrenceType,
      recurrenceInterval: data.recurrenceInterval.present
          ? data.recurrenceInterval.value
          : this.recurrenceInterval,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRecord(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('dueDate: $dueDate, ')
          ..write('amount: $amount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceInterval: $recurrenceInterval, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuid,
      title,
      description,
      category,
      dueDate,
      amount,
      currencyCode,
      isRecurring,
      recurrenceType,
      recurrenceInterval,
      isCompleted,
      completedAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRecord &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.dueDate == this.dueDate &&
          other.amount == this.amount &&
          other.currencyCode == this.currencyCode &&
          other.isRecurring == this.isRecurring &&
          other.recurrenceType == this.recurrenceType &&
          other.recurrenceInterval == this.recurrenceInterval &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RemindersTableCompanion extends UpdateCompanion<ReminderRecord> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> category;
  final Value<DateTime> dueDate;
  final Value<double?> amount;
  final Value<String> currencyCode;
  final Value<bool> isRecurring;
  final Value<String?> recurrenceType;
  final Value<int?> recurrenceInterval;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RemindersTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceInterval = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RemindersTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String title,
    this.description = const Value.absent(),
    required String category,
    required DateTime dueDate,
    this.amount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceInterval = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : uuid = Value(uuid),
        title = Value(title),
        category = Value(category),
        dueDate = Value(dueDate);
  static Insertable<ReminderRecord> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<DateTime>? dueDate,
    Expression<double>? amount,
    Expression<String>? currencyCode,
    Expression<bool>? isRecurring,
    Expression<String>? recurrenceType,
    Expression<int>? recurrenceInterval,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (dueDate != null) 'due_date': dueDate,
      if (amount != null) 'amount': amount,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (recurrenceType != null) 'recurrence_type': recurrenceType,
      if (recurrenceInterval != null) 'recurrence_interval': recurrenceInterval,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RemindersTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? category,
      Value<DateTime>? dueDate,
      Value<double?>? amount,
      Value<String>? currencyCode,
      Value<bool>? isRecurring,
      Value<String?>? recurrenceType,
      Value<int?>? recurrenceInterval,
      Value<bool>? isCompleted,
      Value<DateTime?>? completedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RemindersTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurrenceInterval: recurrenceInterval ?? this.recurrenceInterval,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (recurrenceType.present) {
      map['recurrence_type'] = Variable<String>(recurrenceType.value);
    }
    if (recurrenceInterval.present) {
      map['recurrence_interval'] = Variable<int>(recurrenceInterval.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('dueDate: $dueDate, ')
          ..write('amount: $amount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceInterval: $recurrenceInterval, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationSchedulesTableTable extends NotificationSchedulesTable
    with
        TableInfo<$NotificationSchedulesTableTable,
            NotificationScheduleRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationSchedulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _reminderIdMeta =
      const VerificationMeta('reminderId');
  @override
  late final GeneratedColumn<int> reminderId = GeneratedColumn<int>(
      'reminder_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES reminders (id) ON DELETE CASCADE'));
  static const VerificationMeta _daysBeforeMeta =
      const VerificationMeta('daysBefore');
  @override
  late final GeneratedColumn<int> daysBefore = GeneratedColumn<int>(
      'days_before', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notificationIdMeta =
      const VerificationMeta('notificationId');
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
      'notification_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, reminderId, daysBefore, notificationId, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_schedules';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificationScheduleRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reminder_id')) {
      context.handle(
          _reminderIdMeta,
          reminderId.isAcceptableOrUnknown(
              data['reminder_id']!, _reminderIdMeta));
    } else if (isInserting) {
      context.missing(_reminderIdMeta);
    }
    if (data.containsKey('days_before')) {
      context.handle(
          _daysBeforeMeta,
          daysBefore.isAcceptableOrUnknown(
              data['days_before']!, _daysBeforeMeta));
    } else if (isInserting) {
      context.missing(_daysBeforeMeta);
    }
    if (data.containsKey('notification_id')) {
      context.handle(
          _notificationIdMeta,
          notificationId.isAcceptableOrUnknown(
              data['notification_id']!, _notificationIdMeta));
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationScheduleRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationScheduleRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reminderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reminder_id'])!,
      daysBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}days_before'])!,
      notificationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}notification_id'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $NotificationSchedulesTableTable createAlias(String alias) {
    return $NotificationSchedulesTableTable(attachedDatabase, alias);
  }
}

class NotificationScheduleRecord extends DataClass
    implements Insertable<NotificationScheduleRecord> {
  final int id;
  final int reminderId;

  /// Days before dueDate to fire this notification
  final int daysBefore;

  /// Unique Android notification ID for this schedule
  final int notificationId;
  final bool isActive;
  const NotificationScheduleRecord(
      {required this.id,
      required this.reminderId,
      required this.daysBefore,
      required this.notificationId,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reminder_id'] = Variable<int>(reminderId);
    map['days_before'] = Variable<int>(daysBefore);
    map['notification_id'] = Variable<int>(notificationId);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  NotificationSchedulesTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationSchedulesTableCompanion(
      id: Value(id),
      reminderId: Value(reminderId),
      daysBefore: Value(daysBefore),
      notificationId: Value(notificationId),
      isActive: Value(isActive),
    );
  }

  factory NotificationScheduleRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationScheduleRecord(
      id: serializer.fromJson<int>(json['id']),
      reminderId: serializer.fromJson<int>(json['reminderId']),
      daysBefore: serializer.fromJson<int>(json['daysBefore']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reminderId': serializer.toJson<int>(reminderId),
      'daysBefore': serializer.toJson<int>(daysBefore),
      'notificationId': serializer.toJson<int>(notificationId),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  NotificationScheduleRecord copyWith(
          {int? id,
          int? reminderId,
          int? daysBefore,
          int? notificationId,
          bool? isActive}) =>
      NotificationScheduleRecord(
        id: id ?? this.id,
        reminderId: reminderId ?? this.reminderId,
        daysBefore: daysBefore ?? this.daysBefore,
        notificationId: notificationId ?? this.notificationId,
        isActive: isActive ?? this.isActive,
      );
  NotificationScheduleRecord copyWithCompanion(
      NotificationSchedulesTableCompanion data) {
    return NotificationScheduleRecord(
      id: data.id.present ? data.id.value : this.id,
      reminderId:
          data.reminderId.present ? data.reminderId.value : this.reminderId,
      daysBefore:
          data.daysBefore.present ? data.daysBefore.value : this.daysBefore,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationScheduleRecord(')
          ..write('id: $id, ')
          ..write('reminderId: $reminderId, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('notificationId: $notificationId, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, reminderId, daysBefore, notificationId, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationScheduleRecord &&
          other.id == this.id &&
          other.reminderId == this.reminderId &&
          other.daysBefore == this.daysBefore &&
          other.notificationId == this.notificationId &&
          other.isActive == this.isActive);
}

class NotificationSchedulesTableCompanion
    extends UpdateCompanion<NotificationScheduleRecord> {
  final Value<int> id;
  final Value<int> reminderId;
  final Value<int> daysBefore;
  final Value<int> notificationId;
  final Value<bool> isActive;
  const NotificationSchedulesTableCompanion({
    this.id = const Value.absent(),
    this.reminderId = const Value.absent(),
    this.daysBefore = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  NotificationSchedulesTableCompanion.insert({
    this.id = const Value.absent(),
    required int reminderId,
    required int daysBefore,
    required int notificationId,
    this.isActive = const Value.absent(),
  })  : reminderId = Value(reminderId),
        daysBefore = Value(daysBefore),
        notificationId = Value(notificationId);
  static Insertable<NotificationScheduleRecord> custom({
    Expression<int>? id,
    Expression<int>? reminderId,
    Expression<int>? daysBefore,
    Expression<int>? notificationId,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reminderId != null) 'reminder_id': reminderId,
      if (daysBefore != null) 'days_before': daysBefore,
      if (notificationId != null) 'notification_id': notificationId,
      if (isActive != null) 'is_active': isActive,
    });
  }

  NotificationSchedulesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? reminderId,
      Value<int>? daysBefore,
      Value<int>? notificationId,
      Value<bool>? isActive}) {
    return NotificationSchedulesTableCompanion(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      daysBefore: daysBefore ?? this.daysBefore,
      notificationId: notificationId ?? this.notificationId,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reminderId.present) {
      map['reminder_id'] = Variable<int>(reminderId.value);
    }
    if (daysBefore.present) {
      map['days_before'] = Variable<int>(daysBefore.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSchedulesTableCompanion(')
          ..write('id: $id, ')
          ..write('reminderId: $reminderId, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('notificationId: $notificationId, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $CustomCategoriesTableTable extends CustomCategoriesTable
    with TableInfo<$CustomCategoriesTableTable, CustomCategoryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomCategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, colorValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_categories';
  @override
  VerificationContext validateIntegrity(
      Insertable<CustomCategoryRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomCategoryRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomCategoryRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
    );
  }

  @override
  $CustomCategoriesTableTable createAlias(String alias) {
    return $CustomCategoriesTableTable(attachedDatabase, alias);
  }
}

class CustomCategoryRecord extends DataClass
    implements Insertable<CustomCategoryRecord> {
  final int id;
  final String name;
  final int colorValue;
  const CustomCategoryRecord(
      {required this.id, required this.name, required this.colorValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color_value'] = Variable<int>(colorValue);
    return map;
  }

  CustomCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CustomCategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      colorValue: Value(colorValue),
    );
  }

  factory CustomCategoryRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomCategoryRecord(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int>(colorValue),
    };
  }

  CustomCategoryRecord copyWith({int? id, String? name, int? colorValue}) =>
      CustomCategoryRecord(
        id: id ?? this.id,
        name: name ?? this.name,
        colorValue: colorValue ?? this.colorValue,
      );
  CustomCategoryRecord copyWithCompanion(CustomCategoriesTableCompanion data) {
    return CustomCategoryRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomCategoryRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomCategoryRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorValue == this.colorValue);
}

class CustomCategoriesTableCompanion
    extends UpdateCompanion<CustomCategoryRecord> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> colorValue;
  const CustomCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
  });
  CustomCategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int colorValue,
  })  : name = Value(name),
        colorValue = Value(colorValue);
  static Insertable<CustomCategoryRecord> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? colorValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
    });
  }

  CustomCategoriesTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? colorValue}) {
    return CustomCategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RemindersTableTable remindersTable = $RemindersTableTable(this);
  late final $NotificationSchedulesTableTable notificationSchedulesTable =
      $NotificationSchedulesTableTable(this);
  late final $CustomCategoriesTableTable customCategoriesTable =
      $CustomCategoriesTableTable(this);
  late final RemindersDao remindersDao = RemindersDao(this as AppDatabase);
  late final NotificationSchedulesDao notificationSchedulesDao =
      NotificationSchedulesDao(this as AppDatabase);
  late final CustomCategoriesDao customCategoriesDao =
      CustomCategoriesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [remindersTable, notificationSchedulesTable, customCategoriesTable];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('reminders',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('notification_schedules', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$RemindersTableTableCreateCompanionBuilder = RemindersTableCompanion
    Function({
  Value<int> id,
  required String uuid,
  required String title,
  Value<String?> description,
  required String category,
  required DateTime dueDate,
  Value<double?> amount,
  Value<String> currencyCode,
  Value<bool> isRecurring,
  Value<String?> recurrenceType,
  Value<int?> recurrenceInterval,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$RemindersTableTableUpdateCompanionBuilder = RemindersTableCompanion
    Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> title,
  Value<String?> description,
  Value<String> category,
  Value<DateTime> dueDate,
  Value<double?> amount,
  Value<String> currencyCode,
  Value<bool> isRecurring,
  Value<String?> recurrenceType,
  Value<int?> recurrenceInterval,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$RemindersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RemindersTableTable,
    ReminderRecord,
    $$RemindersTableTableFilterComposer,
    $$RemindersTableTableOrderingComposer,
    $$RemindersTableTableCreateCompanionBuilder,
    $$RemindersTableTableUpdateCompanionBuilder> {
  $$RemindersTableTableTableManager(
      _$AppDatabase db, $RemindersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RemindersTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RemindersTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<double?> amount = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<bool> isRecurring = const Value.absent(),
            Value<String?> recurrenceType = const Value.absent(),
            Value<int?> recurrenceInterval = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RemindersTableCompanion(
            id: id,
            uuid: uuid,
            title: title,
            description: description,
            category: category,
            dueDate: dueDate,
            amount: amount,
            currencyCode: currencyCode,
            isRecurring: isRecurring,
            recurrenceType: recurrenceType,
            recurrenceInterval: recurrenceInterval,
            isCompleted: isCompleted,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required String title,
            Value<String?> description = const Value.absent(),
            required String category,
            required DateTime dueDate,
            Value<double?> amount = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<bool> isRecurring = const Value.absent(),
            Value<String?> recurrenceType = const Value.absent(),
            Value<int?> recurrenceInterval = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RemindersTableCompanion.insert(
            id: id,
            uuid: uuid,
            title: title,
            description: description,
            category: category,
            dueDate: dueDate,
            amount: amount,
            currencyCode: currencyCode,
            isRecurring: isRecurring,
            recurrenceType: recurrenceType,
            recurrenceInterval: recurrenceInterval,
            isCompleted: isCompleted,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$RemindersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dueDate => $state.composableBuilder(
      column: $state.table.dueDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currencyCode => $state.composableBuilder(
      column: $state.table.currencyCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isRecurring => $state.composableBuilder(
      column: $state.table.isRecurring,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get recurrenceType => $state.composableBuilder(
      column: $state.table.recurrenceType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get recurrenceInterval => $state.composableBuilder(
      column: $state.table.recurrenceInterval,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter notificationSchedulesTableRefs(
      ComposableFilter Function(
              $$NotificationSchedulesTableTableFilterComposer f)
          f) {
    final $$NotificationSchedulesTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.notificationSchedulesTable,
            getReferencedColumn: (t) => t.reminderId,
            builder: (joinBuilder, parentComposers) =>
                $$NotificationSchedulesTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.notificationSchedulesTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$RemindersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dueDate => $state.composableBuilder(
      column: $state.table.dueDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currencyCode => $state.composableBuilder(
      column: $state.table.currencyCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isRecurring => $state.composableBuilder(
      column: $state.table.isRecurring,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get recurrenceType => $state.composableBuilder(
      column: $state.table.recurrenceType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get recurrenceInterval => $state.composableBuilder(
      column: $state.table.recurrenceInterval,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$NotificationSchedulesTableTableCreateCompanionBuilder
    = NotificationSchedulesTableCompanion Function({
  Value<int> id,
  required int reminderId,
  required int daysBefore,
  required int notificationId,
  Value<bool> isActive,
});
typedef $$NotificationSchedulesTableTableUpdateCompanionBuilder
    = NotificationSchedulesTableCompanion Function({
  Value<int> id,
  Value<int> reminderId,
  Value<int> daysBefore,
  Value<int> notificationId,
  Value<bool> isActive,
});

class $$NotificationSchedulesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationSchedulesTableTable,
    NotificationScheduleRecord,
    $$NotificationSchedulesTableTableFilterComposer,
    $$NotificationSchedulesTableTableOrderingComposer,
    $$NotificationSchedulesTableTableCreateCompanionBuilder,
    $$NotificationSchedulesTableTableUpdateCompanionBuilder> {
  $$NotificationSchedulesTableTableTableManager(
      _$AppDatabase db, $NotificationSchedulesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$NotificationSchedulesTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$NotificationSchedulesTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> reminderId = const Value.absent(),
            Value<int> daysBefore = const Value.absent(),
            Value<int> notificationId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              NotificationSchedulesTableCompanion(
            id: id,
            reminderId: reminderId,
            daysBefore: daysBefore,
            notificationId: notificationId,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int reminderId,
            required int daysBefore,
            required int notificationId,
            Value<bool> isActive = const Value.absent(),
          }) =>
              NotificationSchedulesTableCompanion.insert(
            id: id,
            reminderId: reminderId,
            daysBefore: daysBefore,
            notificationId: notificationId,
            isActive: isActive,
          ),
        ));
}

class $$NotificationSchedulesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NotificationSchedulesTableTable> {
  $$NotificationSchedulesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get daysBefore => $state.composableBuilder(
      column: $state.table.daysBefore,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get notificationId => $state.composableBuilder(
      column: $state.table.notificationId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RemindersTableTableFilterComposer get reminderId {
    final $$RemindersTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reminderId,
        referencedTable: $state.db.remindersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RemindersTableTableFilterComposer(ComposerState($state.db,
                $state.db.remindersTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$NotificationSchedulesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NotificationSchedulesTableTable> {
  $$NotificationSchedulesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get daysBefore => $state.composableBuilder(
      column: $state.table.daysBefore,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get notificationId => $state.composableBuilder(
      column: $state.table.notificationId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RemindersTableTableOrderingComposer get reminderId {
    final $$RemindersTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.reminderId,
            referencedTable: $state.db.remindersTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$RemindersTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.remindersTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CustomCategoriesTableTableCreateCompanionBuilder
    = CustomCategoriesTableCompanion Function({
  Value<int> id,
  required String name,
  required int colorValue,
});
typedef $$CustomCategoriesTableTableUpdateCompanionBuilder
    = CustomCategoriesTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> colorValue,
});

class $$CustomCategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomCategoriesTableTable,
    CustomCategoryRecord,
    $$CustomCategoriesTableTableFilterComposer,
    $$CustomCategoriesTableTableOrderingComposer,
    $$CustomCategoriesTableTableCreateCompanionBuilder,
    $$CustomCategoriesTableTableUpdateCompanionBuilder> {
  $$CustomCategoriesTableTableTableManager(
      _$AppDatabase db, $CustomCategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$CustomCategoriesTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$CustomCategoriesTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
          }) =>
              CustomCategoriesTableCompanion(
            id: id,
            name: name,
            colorValue: colorValue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int colorValue,
          }) =>
              CustomCategoriesTableCompanion.insert(
            id: id,
            name: name,
            colorValue: colorValue,
          ),
        ));
}

class $$CustomCategoriesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CustomCategoriesTableTable> {
  $$CustomCategoriesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get colorValue => $state.composableBuilder(
      column: $state.table.colorValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CustomCategoriesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CustomCategoriesTableTable> {
  $$CustomCategoriesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get colorValue => $state.composableBuilder(
      column: $state.table.colorValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RemindersTableTableTableManager get remindersTable =>
      $$RemindersTableTableTableManager(_db, _db.remindersTable);
  $$NotificationSchedulesTableTableTableManager
      get notificationSchedulesTable =>
          $$NotificationSchedulesTableTableTableManager(
              _db, _db.notificationSchedulesTable);
  $$CustomCategoriesTableTableTableManager get customCategoriesTable =>
      $$CustomCategoriesTableTableTableManager(_db, _db.customCategoriesTable);
}
