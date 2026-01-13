package com.emarsys.reactnative.wrapper

import com.emarsys.Emarsys
import com.emarsys.reactnative.utils.StorageUtils
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class NativeEmarsysConfig(reactContext: ReactApplicationContext) : NativeEmarsysConfigSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsysConfig"
  }

  override fun getName() = NAME

  override fun changeApplicationCode(applicationCode: String?, promise: Promise) {
    try {
      Emarsys.config.changeApplicationCode(applicationCode) { errorCause ->
        if (errorCause != null) {
          promise.reject(NAME, "Error changeApplicationCode: ", errorCause)
        } else {
          StorageUtils.setSharedPreferencesString(reactApplicationContext, "applicationCode", applicationCode ?: "")
          promise.resolve(null)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "Error changeApplicationCode: ", e)
    }
  }

  override fun changeMerchantId(merchantId: String?, promise: Promise) {
    try {
      Emarsys.config.changeMerchantId(merchantId) // changeMerchantId has no callback
      StorageUtils.setSharedPreferencesString(reactApplicationContext, "merchantId", merchantId ?: "")
      promise.resolve(null)
    } catch (e: Exception) {
      promise.reject(NAME, "Error changeMerchantId: ", e)
    }
  }

  override fun getApplicationCode(promise: Promise) {
    try {
      val applicationCode = Emarsys.config.applicationCode
      promise.resolve(applicationCode)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getApplicationCode: ", e)
    }
  }

  override fun getMerchantId(promise: Promise) {
    try {
      val merchantId = Emarsys.config.merchantId
      promise.resolve(merchantId)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getMerchantId: ", e)
    }
  }

  override fun getContactFieldId(promise: Promise) {
    try {
      val contactFieldId = Emarsys.config.contactFieldId
      promise.resolve(contactFieldId)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getContactFieldId: ", e)
    }
  }

  override fun getClientId(promise: Promise) {
    try {
      val clientId = Emarsys.config.clientId
      promise.resolve(clientId)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getClientId: ", e)
    }
  }

  override fun getLanguageCode(promise: Promise) {
    try {
      val languageCode = Emarsys.config.languageCode
      promise.resolve(languageCode)
    } catch (e: Exception) {
      promise.reject(NAME, "Error getLanguageCode: ", e)
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
