package com.emarsys.reactnative.wrapper

import com.emarsys.Emarsys
import com.emarsys.reactnative.utils.ArrayUtils
import com.emarsys.reactnative.utils.MapUtils
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.ReadableMap

class NativeEmarsysPredict(reactContext: ReactApplicationContext) : NativeEmarsysPredictSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsysPredict"
  }

  override fun getName() = NAME

  override fun trackCart(items: ReadableArray, promise: Promise) {
    try {
      Emarsys.predict.trackCart(ArrayUtils.toList(items, MapUtils::toCartItem)!!)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackCart", e)
    }
  }

  override fun trackPurchase(orderId: String, items: ReadableArray, promise: Promise) {
    try {
      // Emarsys.predict.
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackPurchase", e)
    }
  }

  override fun trackItemView(itemId: String, promise: Promise) {
    try {
      // Emarsys.predict.
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackItemView", e)
    }
  }

  override fun trackCategoryView(categoryPath: String, promise: Promise) {
    try {
      // Emarsys.predict.
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackCategoryView", e)
    }
  }

  override fun trackSearchTerm(searchTerm: String, promise: Promise) {
    try {
      // Emarsys.predict.
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackSearchTerm", e)
    }
  }

  override fun trackTag(tag: String, attributes: ReadableMap?, promise: Promise) {
    try {
      // Emarsys.predict.
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackTag", e)
    }
  }

  override fun recommendProducts(logic: ReadableMap, filters: ReadableArray?, limit: Double?, availabilityZone: String?, promise: Promise) {
    try {
      // Emarsys.predict.
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "recommendProducts", e)
    }
  }

  override fun trackRecommendationClick(product: ReadableMap, promise: Promise) {
    try {
      // Emarsys.predict.
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackRecommendationClick", e)
    }
  }

}
