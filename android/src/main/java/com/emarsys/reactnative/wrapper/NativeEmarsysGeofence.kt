package com.emarsys.reactnative.wrapper

import com.emarsys.Emarsys
import com.emarsys.reactnative.utils.ArrayUtils.toWritableArray
import com.emarsys.reactnative.utils.mappers.GeofenceMapper
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class NativeEmarsysGeofence(reactContext: ReactApplicationContext) : NativeEmarsysGeofenceSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsysGeofence"
  }

  override fun getName() = NAME

  override fun requestAlwaysAuthorization(promise: Promise) {
    // empty implementation
  }

  override fun enable(promise: Promise) {
    try {
      Emarsys.geofence.enable { errorCause: Throwable? ->
        if (errorCause == null) {
          promise.resolve(null)
        } else {
          promise.reject(NAME, "enable", errorCause)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "enable", e)
    }
  }

  override fun disable(promise: Promise) {
    try {
      Emarsys.geofence.disable()
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "disable", e)
    }
  }

  override fun isEnabled(promise: Promise) {
    try {
      val isEnabled = Emarsys.geofence.isEnabled()
      promise.resolve(isEnabled)
    } catch (e: Exception) {
      promise.reject(NAME, "isEnabled", e)
    }
  }

  override fun setInitialEnterTriggerEnabled(enabled: Boolean, promise: Promise) {
    try {
      Emarsys.geofence.setInitialEnterTriggerEnabled(enabled)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "setInitialEnterTriggerEnabled", e)
    }
  }

  override fun getRegisteredGeofences(promise: Promise) {
    try {
      val registeredGeofences = Emarsys.geofence.registeredGeofences.toWritableArray(GeofenceMapper::toWritableMap)
      promise.resolve(registeredGeofences)
    } catch (e: Exception) {
      promise.reject(NAME, "getRegisteredGeofences", e)
    }
  }

}
