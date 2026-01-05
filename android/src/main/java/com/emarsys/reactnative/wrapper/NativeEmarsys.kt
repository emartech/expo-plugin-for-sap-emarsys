package com.emarsys.reactnative.wrapper

import com.emarsys.Emarsys
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class NativeEmarsys(reactContext: ReactApplicationContext) : NativeEmarsysSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsys"
  }

  override fun getName() = NAME

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
