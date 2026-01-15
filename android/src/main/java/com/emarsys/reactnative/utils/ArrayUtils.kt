package com.emarsys.reactnative.utils

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableArray
import org.json.JSONArray
import org.json.JSONObject

object ArrayUtils {

  fun toList(string: String?, delimiter: String = ","): List<String>? {
    return string
      ?.split(delimiter)
      ?.map { it.trim() }
      ?.filter { it.isNotEmpty() }
      ?: null
  }

  fun <T> toList(readableArray: ReadableArray?, mapper: (readableMap: ReadableMap?) -> T?): List<T>? {
    if (readableArray == null) {
      return null
    }

    val list = mutableListOf<T>()
    for (i in 0..<readableArray.size()) {
      val readableMap = readableArray.getMap(i)
      val value = mapper(readableMap)

      if (value != null) {
        list.add(value)
      }
    }

    return list
  }

  fun toWritableArray(jsonArray: JSONArray?): WritableArray? {
    if (jsonArray == null) {
      return null
    }

    val writableArray = Arguments.createArray()
    for (i in 0..<jsonArray.length()) {
      val value = jsonArray.opt(i)

      if (value is String) {
        writableArray.pushString(jsonArray.getString(i))
      } else if (value is Double || value is Float) {
        writableArray.pushDouble(jsonArray.getDouble(i))
      } else if (value is Integer || value is Number) {
        writableArray.pushInt(jsonArray.getInt(i))
      } else if (value is Boolean) {
        writableArray.pushBoolean(jsonArray.getBoolean(i))
      } else if (value is JSONObject) {
        writableArray.pushMap(MapUtils.toWritableMap(jsonArray.getJSONObject(i)))
      } else if (value is JSONArray) {
        writableArray.pushArray(toWritableArray(jsonArray.getJSONArray(i)))
      } else if (value == JSONObject.NULL || value == null) {
        writableArray.pushNull()
      }
    }

    return writableArray
  }

}
