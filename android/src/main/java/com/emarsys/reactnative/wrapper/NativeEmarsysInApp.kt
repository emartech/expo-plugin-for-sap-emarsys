package com.emarsys.reactnative.wrapper

import com.emarsys.Emarsys
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class NativeEmarsysInApp(reactContext: ReactApplicationContext) : NativeEmarsysInAppSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsysInApp"
  }

  override fun getName() = NAME

  override fun pause(promise: Promise) {
    try {
      Emarsys.inApp.pause()
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "pause", e)
    }
  }

  override fun resume(promise: Promise) {
    try {
      Emarsys.inApp.resume()
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "resume", e)
    }
  }

  override fun isPaused(promise: Promise) {
    try {
      val isPaused = Emarsys.inApp.isPaused
      promise.resolve(isPaused)
    } catch (e: Exception) {      
      promise.reject(NAME, "isPaused", e)
    } 
  }

}
