package com.emarsys.reactnative.wrapper

import com.facebook.react.BaseReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import com.facebook.react.uimanager.ViewManager

class EmarsysPackage : BaseReactPackage() {

  override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? =
    when (name) {
      NativeEmarsys.NAME -> NativeEmarsys(reactContext)
      NativeEmarsysPush.NAME -> NativeEmarsysPush(reactContext)
      NativeEmarsysConfig.NAME -> NativeEmarsysConfig(reactContext)
      else -> null
    }

  override fun getReactModuleInfoProvider() = ReactModuleInfoProvider {
    mapOf(
      NativeEmarsys.NAME to ReactModuleInfo(
        name = NativeEmarsys.NAME,
        className = NativeEmarsys.NAME,
        canOverrideExistingModule = false,
        needsEagerInit = false,
        isCxxModule = false,
        isTurboModule = true
      ),
      NativeEmarsysPush.NAME to ReactModuleInfo(
        name = NativeEmarsysPush.NAME,
        className = NativeEmarsysPush.NAME,
        canOverrideExistingModule = false,
        needsEagerInit = false,
        isCxxModule = false,
        isTurboModule = true
      ),
      NativeEmarsysConfig.NAME to ReactModuleInfo(
        name = NativeEmarsysConfig.NAME,
        className = NativeEmarsysConfig.NAME,
        canOverrideExistingModule = false,
        needsEagerInit = false,
        isCxxModule = false,
        isTurboModule = true
      )
    )
  }

  override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> =
    listOf(InlineInAppViewManager(reactContext))

}
