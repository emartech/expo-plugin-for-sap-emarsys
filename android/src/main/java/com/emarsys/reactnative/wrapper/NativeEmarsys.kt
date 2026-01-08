package com.emarsys.reactnative.wrapper

import android.content.Context
import com.emarsys.Emarsys
import com.emarsys.reactnative.utils.EventUtils
import com.emarsys.reactnative.utils.MapUtils
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import org.json.JSONObject

class NativeEmarsys(reactContext: ReactApplicationContext) : NativeEmarsysSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsys"
  }

  override fun getName() = NAME

  override fun setEventHandler(promise: Promise) {
    EventUtils.setEventHandler { context: Context, eventName: String, payload: JSONObject? ->
      emitOnEvent(MapUtils.toWritableMap(JSONObject().put("name", eventName).put("payload", payload)))
    }
    promise.resolve(null)
  }

  override fun getClientId(promise: Promise) {
    try {
      val clientId = Emarsys.config.clientId
      promise.resolve(clientId)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getClientId: ", e)
    }
  }

  override fun getSdkVersion(promise: Promise) {
    try {
      val sdkVersion = Emarsys.config.sdkVersion
      promise.resolve(sdkVersion)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getSdkVersion: ", e)
    }
  }

}
