package com.emarsys.reactnative.wrapper

import com.emarsys.core.api.result.ResultListener
import com.emarsys.core.api.result.Try
import com.emarsys.Emarsys
import com.emarsys.predict.api.model.Product
import com.emarsys.reactnative.utils.ArrayUtils.toList
import com.emarsys.reactnative.utils.ArrayUtils.toWritableArray
import com.emarsys.reactnative.utils.mappers.CartItemMapper
import com.emarsys.reactnative.utils.mappers.FilterMapper
import com.emarsys.reactnative.utils.mappers.LogicMapper
import com.emarsys.reactnative.utils.mappers.ProductMapper
import com.emarsys.reactnative.utils.MapUtils.toStringMap
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
      Emarsys.predict.trackCart(items.toList(CartItemMapper::toModel))
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackCart", e)
    }
  }

  override fun trackPurchase(orderId: String, items: ReadableArray, promise: Promise) {
    try {
      Emarsys.predict.trackPurchase(orderId, items.toList(CartItemMapper::toModel))
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackPurchase", e)
    }
  }

  override fun trackItemView(itemId: String, promise: Promise) {
    try {
      Emarsys.predict.trackItemView(itemId)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackItemView", e)
    }
  }

  override fun trackCategoryView(categoryPath: String, promise: Promise) {
    try {
      Emarsys.predict.trackCategoryView(categoryPath)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackCategoryView", e)
    }
  }

  override fun trackSearchTerm(searchTerm: String, promise: Promise) {
    try {
      Emarsys.predict.trackSearchTerm(searchTerm)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackSearchTerm", e)
    }
  }

  override fun trackTag(tag: String, attributes: ReadableMap?, promise: Promise) {
    try {
      Emarsys.predict.trackTag(tag, attributes?.toStringMap())
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackTag", e)
    }
  }

  override fun recommendProducts(logic: ReadableMap, filters: ReadableArray?, limit: Double?, availabilityZone: String?, promise: Promise) {
    try {
      val _logic = LogicMapper.toModel(logic)!!
      val _filters = filters?.toList(FilterMapper::toModel)
      val _limit = limit?.toInt()
      val resultListener = ResultListener<Try<List<Product>>> { result: Try<List<Product>> ->
        if (result.errorCause == null) {
          val products = result.result?.toWritableArray(ProductMapper::toWritableMap)
          promise.resolve(products)
        } else {
          promise.reject(NAME, "recommendProducts", result.errorCause)
        }
      }

      if (_filters != null && _limit != null && availabilityZone != null) {
        Emarsys.predict.recommendProducts(_logic, _filters, _limit, availabilityZone, resultListener);
      } else if (_filters != null && _limit != null) {
        Emarsys.predict.recommendProducts(_logic, _filters, _limit, resultListener);
      } else if (_filters != null && availabilityZone != null) {
        Emarsys.predict.recommendProducts(_logic, _filters, availabilityZone, resultListener);
      } else if (_limit != null && availabilityZone != null) {
        Emarsys.predict.recommendProducts(_logic, _limit, availabilityZone, resultListener);
      } else if (_filters != null) {
        Emarsys.predict.recommendProducts(_logic, _filters, resultListener);
      } else if (_limit != null) {
        Emarsys.predict.recommendProducts(_logic, _limit, resultListener);
      } else if (availabilityZone != null) {
        Emarsys.predict.recommendProducts(_logic, availabilityZone, resultListener);
      } else {
        Emarsys.predict.recommendProducts(_logic, resultListener);
      }
    } catch (e: Exception) {
      promise.reject(NAME, "recommendProducts", e)
    }
  }

  override fun trackRecommendationClick(product: ReadableMap, promise: Promise) {
    try {
      Emarsys.predict.trackRecommendationClick(ProductMapper.toModel(product)!!)
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "trackRecommendationClick", e)
    }
  }

}
