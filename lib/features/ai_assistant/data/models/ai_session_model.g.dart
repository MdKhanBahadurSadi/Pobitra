// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_session_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAiSessionCollection on Isar {
  IsarCollection<AiSession> get aiSessions => this.collection();
}

const AiSessionSchema = CollectionSchema(
  name: r'AiSession',
  id: 3357995766942205618,
  properties: {
    r'conversationHistoryJson': PropertySchema(
      id: 0,
      name: r'conversationHistoryJson',
      type: IsarType.stringList,
    ),
    r'lastAccessed': PropertySchema(
      id: 1,
      name: r'lastAccessed',
      type: IsarType.dateTime,
    ),
    r'pageTextContext': PropertySchema(
      id: 2,
      name: r'pageTextContext',
      type: IsarType.string,
    ),
    r'tabUrl': PropertySchema(
      id: 3,
      name: r'tabUrl',
      type: IsarType.string,
    )
  },
  estimateSize: _aiSessionEstimateSize,
  serialize: _aiSessionSerialize,
  deserialize: _aiSessionDeserialize,
  deserializeProp: _aiSessionDeserializeProp,
  idName: r'id',
  indexes: {
    r'tabUrl': IndexSchema(
      id: -6841450871491295718,
      name: r'tabUrl',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'tabUrl',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _aiSessionGetId,
  getLinks: _aiSessionGetLinks,
  attach: _aiSessionAttach,
  version: '3.1.0+1',
);

int _aiSessionEstimateSize(
  AiSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.conversationHistoryJson.length * 3;
  {
    for (var i = 0; i < object.conversationHistoryJson.length; i++) {
      final value = object.conversationHistoryJson[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.pageTextContext.length * 3;
  bytesCount += 3 + object.tabUrl.length * 3;
  return bytesCount;
}

void _aiSessionSerialize(
  AiSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.conversationHistoryJson);
  writer.writeDateTime(offsets[1], object.lastAccessed);
  writer.writeString(offsets[2], object.pageTextContext);
  writer.writeString(offsets[3], object.tabUrl);
}

AiSession _aiSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AiSession();
  object.conversationHistoryJson = reader.readStringList(offsets[0]) ?? [];
  object.id = id;
  object.lastAccessed = reader.readDateTime(offsets[1]);
  object.pageTextContext = reader.readString(offsets[2]);
  object.tabUrl = reader.readString(offsets[3]);
  return object;
}

P _aiSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _aiSessionGetId(AiSession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aiSessionGetLinks(AiSession object) {
  return [];
}

void _aiSessionAttach(IsarCollection<dynamic> col, Id id, AiSession object) {
  object.id = id;
}

extension AiSessionByIndex on IsarCollection<AiSession> {
  Future<AiSession?> getByTabUrl(String tabUrl) {
    return getByIndex(r'tabUrl', [tabUrl]);
  }

  AiSession? getByTabUrlSync(String tabUrl) {
    return getByIndexSync(r'tabUrl', [tabUrl]);
  }

  Future<bool> deleteByTabUrl(String tabUrl) {
    return deleteByIndex(r'tabUrl', [tabUrl]);
  }

  bool deleteByTabUrlSync(String tabUrl) {
    return deleteByIndexSync(r'tabUrl', [tabUrl]);
  }

  Future<List<AiSession?>> getAllByTabUrl(List<String> tabUrlValues) {
    final values = tabUrlValues.map((e) => [e]).toList();
    return getAllByIndex(r'tabUrl', values);
  }

  List<AiSession?> getAllByTabUrlSync(List<String> tabUrlValues) {
    final values = tabUrlValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'tabUrl', values);
  }

  Future<int> deleteAllByTabUrl(List<String> tabUrlValues) {
    final values = tabUrlValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'tabUrl', values);
  }

  int deleteAllByTabUrlSync(List<String> tabUrlValues) {
    final values = tabUrlValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'tabUrl', values);
  }

  Future<Id> putByTabUrl(AiSession object) {
    return putByIndex(r'tabUrl', object);
  }

  Id putByTabUrlSync(AiSession object, {bool saveLinks = true}) {
    return putByIndexSync(r'tabUrl', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTabUrl(List<AiSession> objects) {
    return putAllByIndex(r'tabUrl', objects);
  }

  List<Id> putAllByTabUrlSync(List<AiSession> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'tabUrl', objects, saveLinks: saveLinks);
  }
}

extension AiSessionQueryWhereSort
    on QueryBuilder<AiSession, AiSession, QWhere> {
  QueryBuilder<AiSession, AiSession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AiSessionQueryWhere
    on QueryBuilder<AiSession, AiSession, QWhereClause> {
  QueryBuilder<AiSession, AiSession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterWhereClause> tabUrlEqualTo(
      String tabUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tabUrl',
        value: [tabUrl],
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterWhereClause> tabUrlNotEqualTo(
      String tabUrl) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tabUrl',
              lower: [],
              upper: [tabUrl],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tabUrl',
              lower: [tabUrl],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tabUrl',
              lower: [tabUrl],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tabUrl',
              lower: [],
              upper: [tabUrl],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AiSessionQueryFilter
    on QueryBuilder<AiSession, AiSession, QFilterCondition> {
  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conversationHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conversationHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conversationHistoryJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conversationHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conversationHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conversationHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conversationHistoryJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conversationHistoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conversationHistoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conversationHistoryJson',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conversationHistoryJson',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conversationHistoryJson',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conversationHistoryJson',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conversationHistoryJson',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      conversationHistoryJsonLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conversationHistoryJson',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> lastAccessedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAccessed',
        value: value,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      lastAccessedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAccessed',
        value: value,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      lastAccessedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAccessed',
        value: value,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> lastAccessedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAccessed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageTextContext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageTextContext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageTextContext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageTextContext',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pageTextContext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pageTextContext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pageTextContext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pageTextContext',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageTextContext',
        value: '',
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition>
      pageTextContextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pageTextContext',
        value: '',
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tabUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tabUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tabUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tabUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tabUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tabUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tabUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tabUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tabUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterFilterCondition> tabUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tabUrl',
        value: '',
      ));
    });
  }
}

extension AiSessionQueryObject
    on QueryBuilder<AiSession, AiSession, QFilterCondition> {}

extension AiSessionQueryLinks
    on QueryBuilder<AiSession, AiSession, QFilterCondition> {}

extension AiSessionQuerySortBy on QueryBuilder<AiSession, AiSession, QSortBy> {
  QueryBuilder<AiSession, AiSession, QAfterSortBy> sortByLastAccessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessed', Sort.asc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> sortByLastAccessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessed', Sort.desc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> sortByPageTextContext() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageTextContext', Sort.asc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> sortByPageTextContextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageTextContext', Sort.desc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> sortByTabUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabUrl', Sort.asc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> sortByTabUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabUrl', Sort.desc);
    });
  }
}

extension AiSessionQuerySortThenBy
    on QueryBuilder<AiSession, AiSession, QSortThenBy> {
  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenByLastAccessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessed', Sort.asc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenByLastAccessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessed', Sort.desc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenByPageTextContext() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageTextContext', Sort.asc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenByPageTextContextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageTextContext', Sort.desc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenByTabUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabUrl', Sort.asc);
    });
  }

  QueryBuilder<AiSession, AiSession, QAfterSortBy> thenByTabUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabUrl', Sort.desc);
    });
  }
}

extension AiSessionQueryWhereDistinct
    on QueryBuilder<AiSession, AiSession, QDistinct> {
  QueryBuilder<AiSession, AiSession, QDistinct>
      distinctByConversationHistoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conversationHistoryJson');
    });
  }

  QueryBuilder<AiSession, AiSession, QDistinct> distinctByLastAccessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAccessed');
    });
  }

  QueryBuilder<AiSession, AiSession, QDistinct> distinctByPageTextContext(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageTextContext',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiSession, AiSession, QDistinct> distinctByTabUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tabUrl', caseSensitive: caseSensitive);
    });
  }
}

extension AiSessionQueryProperty
    on QueryBuilder<AiSession, AiSession, QQueryProperty> {
  QueryBuilder<AiSession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AiSession, List<String>, QQueryOperations>
      conversationHistoryJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conversationHistoryJson');
    });
  }

  QueryBuilder<AiSession, DateTime, QQueryOperations> lastAccessedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAccessed');
    });
  }

  QueryBuilder<AiSession, String, QQueryOperations> pageTextContextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageTextContext');
    });
  }

  QueryBuilder<AiSession, String, QQueryOperations> tabUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tabUrl');
    });
  }
}
