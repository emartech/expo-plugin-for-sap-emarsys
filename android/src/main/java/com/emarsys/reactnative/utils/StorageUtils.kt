package com.emarsys.reactnative.utils

import android.app.Application
import android.content.Context
import android.content.pm.PackageManager
import com.emarsys.config.EmarsysConfig

object StorageUtils {

  private const val STORE_NAME = "com.emarsys.reactnative"

  fun getString(context: Context, key: String): String? {
    val value = getSharedPreferencesString(context, key) ?: getApplicationMetaDataString(context, key)
    return if (value !== "") value else null
  }

  fun getSharedPreferencesString(context: Context, key: String): String? {
    return context
      .getSharedPreferences(STORE_NAME, Context.MODE_PRIVATE)
      .getString(key, null)
  }

  fun getApplicationMetaDataString(context: Context, key: String): String? {
    return context.packageManager
      .getApplicationInfo(context.packageName, PackageManager.GET_META_DATA).metaData
      .getString("${STORE_NAME}.${key}")
  }
  
  fun getApplicationMetaDataBoolean(context: Context, key: String): Boolean {
    return context.packageManager
      .getApplicationInfo(context.packageName, PackageManager.GET_META_DATA).metaData
      .getBoolean("${STORE_NAME}.${key}")
  }

  fun getEmarsysConfig(application: Application): EmarsysConfig {
    return EmarsysConfig(
      application = application,
      applicationCode = getString(application, "applicationCode"),
      merchantId = getString(application, "merchantId"),
      verboseConsoleLoggingEnabled = getApplicationMetaDataBoolean(application, "enableConsoleLogging"),
      sharedPackageNames = ArrayUtils.toList(getApplicationMetaDataString(application, "sharedPackageNames")),
      sharedSecret = getApplicationMetaDataString(application, "sharedSecret")
    )
  }

  fun setSharedPreferencesString(context: Context, key: String, value: String) {
    context
      .getSharedPreferences(STORE_NAME, Context.MODE_PRIVATE)
      .edit().putString(key, value)
      .apply()
  }

}
