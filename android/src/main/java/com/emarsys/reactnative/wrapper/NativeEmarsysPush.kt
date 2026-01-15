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
        if (errorCause != null) {
          promise.reject(NAME, "Error setPushToken: ", errorCause)
        } else {
          promise.resolve(null)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "Error setPushToken: ", e)
    }
  }

  override fun clearPushToken(promise: Promise) {
    try {
      Emarsys.push.clearPushToken { errorCause ->
        if (errorCause != null) {
          promise.reject(NAME, "Error clearPushToken: ", errorCause)
        } else {
          promise.resolve(null)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "Error clearPushToken: ", e)
    }
  }

  override fun getPushToken(promise: Promise) {
    try {
      val pushToken = Emarsys.push.pushToken
      promise.resolve(pushToken)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getPushToken: ", e)
    }
  }
}
