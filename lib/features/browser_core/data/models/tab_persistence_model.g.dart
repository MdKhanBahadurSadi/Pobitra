// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_persistence_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTabPersistenceCollection on Isar {
  IsarCollection<TabPersistence> get tabPersistences => this.collection();
}

const TabPersistenceSchema = CollectionSchema(
  name: r'TabPersistence',
  id: 8974141525736063820,
  properties: {
    r'currentUrl': PropertySchema(
      id: 0,
      name: r'currentUrl',
      type: IsarType.string,
    ),
    r'faviconUrl': PropertySchema(
      id: 1,
      name: r'faviconUrl',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 2,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isIncognito': PropertySchema(
      id: 3,
      name: r'isIncognito',
      type: IsarType.bool,
    ),
    r'position': PropertySchema(
      id: 4,
      name: r'position',
      type: IsarType.long,
    ),
    r'tabId': PropertySchema(
      id: 5,
      name: r'tabId',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 6,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _tabPersistenceEstimateSize,
  serialize: _tabPersistenceSerialize,
  deserialize: _tabPersistenceDeserialize,
  deserializeProp: _tabPersistenceDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tabPersistenceGetId,
  getLinks: _tabPersistenceGetLinks,
  attach: _tabPersistenceAttach,
  version: '3.1.0+1',
);

int _tabPersistenceEstimateSize(
  TabPersistence object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currentUrl.length * 3;
  {
    final value = object.faviconUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tabId.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _tabPersistenceSerialize(
  TabPersistence object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.currentUrl);
  writer.writeString(offsets[1], object.faviconUrl);
  writer.writeBool(offsets[2], object.isActive);
  writer.writeBool(offsets[3], object.isIncognito);
  writer.writeLong(offsets[4], object.position);
  writer.writeString(offsets[5], object.tabId);
  writer.writeString(offsets[6], object.title);
}

TabPersistence _tabPersistenceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TabPersistence();
  object.currentUrl = reader.readString(offsets[0]);
  object.faviconUrl = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.isActive = reader.readBool(offsets[2]);
  object.isIncognito = reader.readBool(offsets[3]);
  object.position = reader.readLong(offsets[4]);
  object.tabId = reader.readString(offsets[5]);
  object.title = reader.readString(offsets[6]);
  return object;
}

P _tabPersistenceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tabPersistenceGetId(TabPersistence object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tabPersistenceGetLinks(TabPersistence object) {
  return [];
}

void _tabPersistenceAttach(
    IsarCollection<dynamic> col, Id id, TabPersistence object) {
  object.id = id;
}

extension TabPersistenceQueryWhereSort
    on QueryBuilder<TabPersistence, TabPersistence, QWhere> {
  QueryBuilder<TabPersistence, TabPersistence, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TabPersistenceQueryWhere
    on QueryBuilder<TabPersistence, TabPersistence, QWhereClause> {
  QueryBuilder<TabPersistence, TabPersistence, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<TabPersistence, TabPersistence, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterWhereClause> idBetween(
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
}

extension TabPersistenceQueryFilter
    on QueryBuilder<TabPersistence, TabPersistence, QFilterCondition> {
  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currentUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      currentUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currentUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'faviconUrl',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'faviconUrl',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'faviconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'faviconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'faviconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'faviconUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'faviconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'faviconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'faviconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'faviconUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'faviconUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      faviconUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'faviconUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      isIncognitoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isIncognito',
        value: value,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      positionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      positionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      positionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tabId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tabId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tabId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tabId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tabId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tabId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tabId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tabId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tabId',
        value: '',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      tabIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tabId',
        value: '',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension TabPersistenceQueryObject
    on QueryBuilder<TabPersistence, TabPersistence, QFilterCondition> {}

extension TabPersistenceQueryLinks
    on QueryBuilder<TabPersistence, TabPersistence, QFilterCondition> {}

extension TabPersistenceQuerySortBy
    on QueryBuilder<TabPersistence, TabPersistence, QSortBy> {
  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByCurrentUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUrl', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByCurrentUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUrl', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByFaviconUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faviconUrl', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByFaviconUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faviconUrl', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByIsIncognito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIncognito', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByIsIncognitoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIncognito', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> sortByTabId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabId', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> sortByTabIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabId', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TabPersistenceQuerySortThenBy
    on QueryBuilder<TabPersistence, TabPersistence, QSortThenBy> {
  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByCurrentUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUrl', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByCurrentUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentUrl', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByFaviconUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faviconUrl', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByFaviconUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faviconUrl', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByIsIncognito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIncognito', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByIsIncognitoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isIncognito', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenByTabId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabId', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenByTabIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabId', Sort.desc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TabPersistenceQueryWhereDistinct
    on QueryBuilder<TabPersistence, TabPersistence, QDistinct> {
  QueryBuilder<TabPersistence, TabPersistence, QDistinct> distinctByCurrentUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QDistinct> distinctByFaviconUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'faviconUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QDistinct>
      distinctByIsIncognito() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isIncognito');
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QDistinct> distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QDistinct> distinctByTabId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tabId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TabPersistence, TabPersistence, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension TabPersistenceQueryProperty
    on QueryBuilder<TabPersistence, TabPersistence, QQueryProperty> {
  QueryBuilder<TabPersistence, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TabPersistence, String, QQueryOperations> currentUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentUrl');
    });
  }

  QueryBuilder<TabPersistence, String?, QQueryOperations> faviconUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'faviconUrl');
    });
  }

  QueryBuilder<TabPersistence, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<TabPersistence, bool, QQueryOperations> isIncognitoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isIncognito');
    });
  }

  QueryBuilder<TabPersistence, int, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }

  QueryBuilder<TabPersistence, String, QQueryOperations> tabIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tabId');
    });
  }

  QueryBuilder<TabPersistence, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
