// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_engine_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSearchEngineCollection on Isar {
  IsarCollection<SearchEngine> get searchEngines => this.collection();
}

const SearchEngineSchema = CollectionSchema(
  name: r'SearchEngine',
  id: -3417034984296118919,
  properties: {
    r'engineName': PropertySchema(
      id: 0,
      name: r'engineName',
      type: IsarType.string,
    ),
    r'iconUrl': PropertySchema(
      id: 1,
      name: r'iconUrl',
      type: IsarType.string,
    ),
    r'isDefault': PropertySchema(
      id: 2,
      name: r'isDefault',
      type: IsarType.bool,
    ),
    r'searchUrlPattern': PropertySchema(
      id: 3,
      name: r'searchUrlPattern',
      type: IsarType.string,
    )
  },
  estimateSize: _searchEngineEstimateSize,
  serialize: _searchEngineSerialize,
  deserialize: _searchEngineDeserialize,
  deserializeProp: _searchEngineDeserializeProp,
  idName: r'id',
  indexes: {
    r'engineName': IndexSchema(
      id: 721365596722130006,
      name: r'engineName',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'engineName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _searchEngineGetId,
  getLinks: _searchEngineGetLinks,
  attach: _searchEngineAttach,
  version: '3.1.0+1',
);

int _searchEngineEstimateSize(
  SearchEngine object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.engineName.length * 3;
  {
    final value = object.iconUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.searchUrlPattern.length * 3;
  return bytesCount;
}

void _searchEngineSerialize(
  SearchEngine object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.engineName);
  writer.writeString(offsets[1], object.iconUrl);
  writer.writeBool(offsets[2], object.isDefault);
  writer.writeString(offsets[3], object.searchUrlPattern);
}

SearchEngine _searchEngineDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SearchEngine();
  object.engineName = reader.readString(offsets[0]);
  object.iconUrl = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.isDefault = reader.readBool(offsets[2]);
  object.searchUrlPattern = reader.readString(offsets[3]);
  return object;
}

P _searchEngineDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _searchEngineGetId(SearchEngine object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _searchEngineGetLinks(SearchEngine object) {
  return [];
}

void _searchEngineAttach(
    IsarCollection<dynamic> col, Id id, SearchEngine object) {
  object.id = id;
}

extension SearchEngineByIndex on IsarCollection<SearchEngine> {
  Future<SearchEngine?> getByEngineName(String engineName) {
    return getByIndex(r'engineName', [engineName]);
  }

  SearchEngine? getByEngineNameSync(String engineName) {
    return getByIndexSync(r'engineName', [engineName]);
  }

  Future<bool> deleteByEngineName(String engineName) {
    return deleteByIndex(r'engineName', [engineName]);
  }

  bool deleteByEngineNameSync(String engineName) {
    return deleteByIndexSync(r'engineName', [engineName]);
  }

  Future<List<SearchEngine?>> getAllByEngineName(
      List<String> engineNameValues) {
    final values = engineNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'engineName', values);
  }

  List<SearchEngine?> getAllByEngineNameSync(List<String> engineNameValues) {
    final values = engineNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'engineName', values);
  }

  Future<int> deleteAllByEngineName(List<String> engineNameValues) {
    final values = engineNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'engineName', values);
  }

  int deleteAllByEngineNameSync(List<String> engineNameValues) {
    final values = engineNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'engineName', values);
  }

  Future<Id> putByEngineName(SearchEngine object) {
    return putByIndex(r'engineName', object);
  }

  Id putByEngineNameSync(SearchEngine object, {bool saveLinks = true}) {
    return putByIndexSync(r'engineName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEngineName(List<SearchEngine> objects) {
    return putAllByIndex(r'engineName', objects);
  }

  List<Id> putAllByEngineNameSync(List<SearchEngine> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'engineName', objects, saveLinks: saveLinks);
  }
}

extension SearchEngineQueryWhereSort
    on QueryBuilder<SearchEngine, SearchEngine, QWhere> {
  QueryBuilder<SearchEngine, SearchEngine, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SearchEngineQueryWhere
    on QueryBuilder<SearchEngine, SearchEngine, QWhereClause> {
  QueryBuilder<SearchEngine, SearchEngine, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SearchEngine, SearchEngine, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterWhereClause> idBetween(
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

  QueryBuilder<SearchEngine, SearchEngine, QAfterWhereClause> engineNameEqualTo(
      String engineName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'engineName',
        value: [engineName],
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterWhereClause>
      engineNameNotEqualTo(String engineName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'engineName',
              lower: [],
              upper: [engineName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'engineName',
              lower: [engineName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'engineName',
              lower: [engineName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'engineName',
              lower: [],
              upper: [engineName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SearchEngineQueryFilter
    on QueryBuilder<SearchEngine, SearchEngine, QFilterCondition> {
  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'engineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'engineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'engineName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'engineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'engineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'engineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'engineName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engineName',
        value: '',
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      engineNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'engineName',
        value: '',
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconUrl',
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconUrl',
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      iconUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      isDefaultEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDefault',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchUrlPattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchUrlPattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchUrlPattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchUrlPattern',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchUrlPattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchUrlPattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchUrlPattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchUrlPattern',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchUrlPattern',
        value: '',
      ));
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterFilterCondition>
      searchUrlPatternIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchUrlPattern',
        value: '',
      ));
    });
  }
}

extension SearchEngineQueryObject
    on QueryBuilder<SearchEngine, SearchEngine, QFilterCondition> {}

extension SearchEngineQueryLinks
    on QueryBuilder<SearchEngine, SearchEngine, QFilterCondition> {}

extension SearchEngineQuerySortBy
    on QueryBuilder<SearchEngine, SearchEngine, QSortBy> {
  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> sortByEngineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineName', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy>
      sortByEngineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineName', Sort.desc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> sortByIconUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> sortByIconUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.desc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> sortByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> sortByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy>
      sortBySearchUrlPattern() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchUrlPattern', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy>
      sortBySearchUrlPatternDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchUrlPattern', Sort.desc);
    });
  }
}

extension SearchEngineQuerySortThenBy
    on QueryBuilder<SearchEngine, SearchEngine, QSortThenBy> {
  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> thenByEngineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineName', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy>
      thenByEngineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineName', Sort.desc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> thenByIconUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> thenByIconUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconUrl', Sort.desc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> thenByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy> thenByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy>
      thenBySearchUrlPattern() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchUrlPattern', Sort.asc);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QAfterSortBy>
      thenBySearchUrlPatternDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchUrlPattern', Sort.desc);
    });
  }
}

extension SearchEngineQueryWhereDistinct
    on QueryBuilder<SearchEngine, SearchEngine, QDistinct> {
  QueryBuilder<SearchEngine, SearchEngine, QDistinct> distinctByEngineName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'engineName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QDistinct> distinctByIconUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QDistinct> distinctByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDefault');
    });
  }

  QueryBuilder<SearchEngine, SearchEngine, QDistinct>
      distinctBySearchUrlPattern({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchUrlPattern',
          caseSensitive: caseSensitive);
    });
  }
}

extension SearchEngineQueryProperty
    on QueryBuilder<SearchEngine, SearchEngine, QQueryProperty> {
  QueryBuilder<SearchEngine, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SearchEngine, String, QQueryOperations> engineNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'engineName');
    });
  }

  QueryBuilder<SearchEngine, String?, QQueryOperations> iconUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconUrl');
    });
  }

  QueryBuilder<SearchEngine, bool, QQueryOperations> isDefaultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDefault');
    });
  }

  QueryBuilder<SearchEngine, String, QQueryOperations>
      searchUrlPatternProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchUrlPattern');
    });
  }
}
