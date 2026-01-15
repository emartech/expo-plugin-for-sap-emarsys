package com.emarsys.reactnative.utils.mappers

import com.emarsys.predict.api.model.RecommendationFilter
import com.emarsys.reactnative.utils.ArrayUtils.toStringList
import com.facebook.react.bridge.ReadableMap

object FilterMapper {

  fun toModel(readableMap: ReadableMap?): RecommendationFilter? {
    if (readableMap == null) {
      return null
    }

    val type = readableMap.getString("type")!!
    val field = readableMap.getString("field")!!
    val comparison = readableMap.getString("comparison")!!
    val expectations = readableMap.getArray("expectations")!!.toStringList()

    return when (type) {
      "INCLUDE" -> when (comparison) {
        "IS" -> RecommendationFilter.include(field).isValue(expectations[0])
        "IN" -> RecommendationFilter.include(field).inValues(expectations)
        "HAS" -> RecommendationFilter.include(field).hasValue(expectations[0])
        "OVERLAPS" -> RecommendationFilter.include(field).overlapsValues(expectations)
        else -> null
      }
      "EXCLUDE" -> when (comparison) {
        "IS" -> RecommendationFilter.exclude(field).isValue(expectations[0])
        "IN" -> RecommendationFilter.exclude(field).inValues(expectations)
        "HAS" -> RecommendationFilter.exclude(field).hasValue(expectations[0])
        "OVERLAPS" -> RecommendationFilter.exclude(field).overlapsValues(expectations)
        else -> null
      }
      else -> null
    }
  }

}
