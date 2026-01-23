package com.emarsys.reactnative.utils.mappers

import com.emarsys.predict.api.model.PredictCartItem
import com.facebook.react.bridge.ReadableMap

object CartItemMapper {

  fun toModel(readableMap: ReadableMap?): PredictCartItem? {
    if (readableMap == null) {
      return null
    }

    return PredictCartItem(
      itemId = readableMap.getString("itemId")!!,
      price = readableMap.getDouble("price"),
      quantity = readableMap.getDouble("quantity")
    )
  }

}
