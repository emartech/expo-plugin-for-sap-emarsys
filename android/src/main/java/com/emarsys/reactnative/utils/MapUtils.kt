package com.emarsys.reactnative.utils

import com.emarsys.predict.api.model.PredictCartItem
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableMap
import org.json.JSONArray
import org.json.JSONObject

object MapUtils {

  fun toMap(readableMap: ReadableMap?): Map<String, String>? {
    if (readableMap == null) {
      return null
    }

    val map = mutableMapOf<String, String>()
    val iterator = readableMap.keySetIterator()
    while (iterator.hasNextKey()) {
      val key = iterator.nextKey()
      val value = readableMap.getString(key)

      if (value != null) {
        map[key] = value
      }
    }

    return map
  }

  fun toWritableMap(jsonObject: JSONObject?): WritableMap? {
    if (jsonObject == null) {
      return null
    }

    val writableMap = Arguments.createMap()
    val iterator = jsonObject.keys()
    while (iterator.hasNext()) {
      val key = iterator.next()
      val value = jsonObject.opt(key)

      if (value is String) {
        writableMap.putString(key, jsonObject.getString(key))
      } else if (value is Double || value is Float) {
        writableMap.putDouble(key, jsonObject.getDouble(key))
      } else if (value is Integer || value is Number) {
        writableMap.putInt(key, jsonObject.getInt(key))
      } else if (value is Boolean) {
        writableMap.putBoolean(key, jsonObject.getBoolean(key))
      } else if (value is JSONObject) {
        writableMap.putMap(key, toWritableMap(jsonObject.getJSONObject(key)))
      } else if (value is JSONArray) {
        writableMap.putArray(key, ArrayUtils.toWritableArray(jsonObject.getJSONArray(key)))
      } else if (value == JSONObject.NULL || value == null) {
        writableMap.putNull(key)
      }
    }

    return writableMap
  }

  fun toCartItem(readableMap: ReadableMap?): PredictCartItem? {    
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
