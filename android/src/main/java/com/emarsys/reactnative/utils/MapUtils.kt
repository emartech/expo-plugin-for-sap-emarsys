package com.emarsys.reactnative.utils

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.UnexpectedNativeTypeException
import com.facebook.react.bridge.WritableMap
import com.facebook.react.bridge.WritableArray
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import java.net.URL

object MapUtils {

  fun put(map: WritableMap, key: String, value: Any?) {
    if (value == null) {
      return
    }

    when (value) {
      is String -> map.putString(key, value)
      is URL -> map.putString(key, value.toString())
      is Boolean -> map.putBoolean(key, value)
      is Int -> map.putInt(key, value)
      is Long -> map.putDouble(key, value.toDouble())
      is Double -> map.putDouble(key, value)
      is Float -> map.putDouble(key, value.toDouble())
      is Map<*, *>  -> {
        val nestedMap = toWritableMap(value as? Map<String, Any?>)
        if (nestedMap != null) {
          map.putMap(key, nestedMap)
        }
      }
      is List<*> -> {
        val array = Arguments.createArray()
        value.forEach { item ->
          when (item) {
            is String -> array.pushString(item)
            is WritableMap -> array.pushMap(item)
            else -> { }
          }
        }
        map.putArray(key, array)
      }
    }
  }

  fun toMap(readableMap: ReadableMap?) : Map<String, String>? {
    if (readableMap == null) {
      return null
    }

    val map = mutableMapOf<String, String>()
    val iterator = readableMap.keySetIterator()
    while (iterator.hasNextKey()) {
      try {
        val key = iterator.nextKey()
        val value = readableMap.getString(key)
        
        if (value != null) {
          map[key] = value
        }
      } catch (e: UnexpectedNativeTypeException) {
        e.printStackTrace()
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
      try {
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
      } catch (e: JSONException) {
        e.printStackTrace()
      }
    }

    return writableMap
  }

  fun toWritableMap(map: Map<String, Any?>?): WritableMap? {
    if (map == null) {
      return null
    }

    val writableMap = Arguments.createMap()
    map.forEach { (key, value) ->
      when (value) {
        is String -> writableMap.putString(key, value)
        is Number -> writableMap.putDouble(key, value.toDouble())
        is Boolean -> writableMap.putBoolean(key, value)
        is Map<*, *> -> writableMap.putMap(key, toWritableMap(value as? Map<String, Any?>))
        null -> writableMap.putNull(key)
        else -> writableMap.putString(key, value.toString())
      }
    }

    return writableMap
  }

}
