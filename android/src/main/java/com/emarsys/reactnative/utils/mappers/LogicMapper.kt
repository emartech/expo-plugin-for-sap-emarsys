package com.emarsys.reactnative.utils.mappers

import com.emarsys.predict.api.model.Logic
import com.emarsys.predict.api.model.RecommendationLogic
import com.emarsys.reactnative.utils.ArrayUtils.toList
import com.emarsys.reactnative.utils.ArrayUtils.toStringList
import com.emarsys.reactnative.utils.mappers.CartItemMapper
import com.facebook.react.bridge.ReadableMap

object LogicMapper {

  fun toModel(readableMap: ReadableMap?): Logic? {
    if (readableMap == null) {
      return null
    }

    val name = readableMap.getString("name")!!
    val query = readableMap.getString("query")
    val cartItems = readableMap.getArray("cartItems")?.toList(CartItemMapper::toModel)
    val variants = readableMap.getArray("variants")?.toStringList()

    return when (name) {
      "SEARCH" ->
        if (query != null) RecommendationLogic.search(query)
        else RecommendationLogic.search()
      "CART" ->
        if (cartItems != null) RecommendationLogic.cart(cartItems)
        else RecommendationLogic.cart()
      "RELATED" ->
        if (query != null) RecommendationLogic.related(query)
        else RecommendationLogic.related()
      "CATEGORY" ->
        if (query != null) RecommendationLogic.category(query)
        else RecommendationLogic.category()
      "ALSO_BOUGHT" ->
        if (query != null) RecommendationLogic.alsoBought(query)
        else RecommendationLogic.alsoBought()
      "POPULAR" ->
        if (query != null) RecommendationLogic.popular(query)
        else RecommendationLogic.popular()
      "PERSONAL" ->
        if (variants != null) RecommendationLogic.personal(variants)
        else RecommendationLogic.personal()
      "HOME" ->
        if (variants != null) RecommendationLogic.home(variants)
        else RecommendationLogic.home()
      else -> null
    }
  }

}
