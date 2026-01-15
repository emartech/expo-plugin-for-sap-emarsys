package com.emarsys.reactnative.wrapper

import com.emarsys.Emarsys
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class NativeEmarsysPush(reactContext: ReactApplicationContext) : NativeEmarsysPushSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsysPush"
  }

  override fun getName() = NAME

  override fun setPushToken(pushToken: String, promise: Promise) {
    try {
      Emarsys.push.setPushToken(pushToken) { errorCause ->
        if (errorCause == null) {
          promise.resolve(null)
        } else {
          promise.reject(NAME, "setPushToken", errorCause)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "setPushToken", e)
    }
  }

  override fun clearPushToken(promise: Promise) {
    try {
      Emarsys.push.clearPushToken { errorCause ->
        if (errorCause == null) {
          promise.resolve(null)
        } else {
          promise.reject(NAME, "clearPushToken", errorCause)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "clearPushToken", e)
    }
  }

  override fun getPushToken(promise: Promise) {
    try {
      val pushToken = Emarsys.push.pushToken
      promise.resolve(pushToken)
    } catch (e: Exception) {
      promise.reject(NAME, "getPushToken", e)
    }
  }
}
