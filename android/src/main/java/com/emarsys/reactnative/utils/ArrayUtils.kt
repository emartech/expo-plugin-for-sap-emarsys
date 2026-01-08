package com.emarsys.reactnative.utils

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableArray
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

object ArrayUtils {

  fun toList(string: String?, delimiter: String = ","): List<String>? {
    return string
      ?.split(delimiter)
      ?.map { it.trim() }
      ?.filter { it.isNotEmpty() }
      ?: null
  }

  fun toWritableArray(jsonArray: JSONArray?): WritableArray? {
    if (jsonArray == null) {
      return null
    }

    val writableArray = Arguments.createArray()
    for (i in 0 until jsonArray.length()) {
      try {
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
      } catch (e: JSONException) {
        e.printStackTrace()
      }
    }

    return writableArray
  }

}
