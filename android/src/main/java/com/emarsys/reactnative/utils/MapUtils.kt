package com.emarsys.reactnative.utils

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

object MapUtils {

  fun toWritableMap(jsonObject: JSONObject?): WritableMap? {
    if (jsonObject == null) {
      return null
    }

    val writableMap = Arguments.createMap()
    val iterator = jsonObject.keys()
    while (iterator.hasNext()) {
      try {
        val key = iterator.next()
        val value = jsonObject.get(key)

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
      } catch (e: JSONException) {
        e.printStackTrace()
      }
    }

    return writableMap
  }

}
