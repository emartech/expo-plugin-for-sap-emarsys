package com.emarsys.reactnative.wrapper

import com.facebook.react.BaseReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import com.facebook.react.uimanager.ViewManager

class EmarsysPackage : BaseReactPackage() {

  val moduleNames = listOf(
    NativeEmarsys.NAME,
    NativeEmarsysPush.NAME,
    NativeEmarsysInApp.NAME,
    NativeEmarsysInbox.NAME,
    NativeEmarsysPredict.NAME,
    NativeEmarsysConfig.NAME,
  )

  override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? =
    when (name) {
      NativeEmarsys.NAME -> NativeEmarsys(reactContext)
      NativeEmarsysPush.NAME -> NativeEmarsysPush(reactContext)
      NativeEmarsysInApp.NAME -> NativeEmarsysInApp(reactContext)
      NativeEmarsysInbox.NAME -> NativeEmarsysInbox(reactContext)
      NativeEmarsysPredict.NAME -> NativeEmarsysPredict(reactContext)
      NativeEmarsysConfig.NAME -> NativeEmarsysConfig(reactContext)
      else -> null
    }

  override fun getReactModuleInfoProvider() = ReactModuleInfoProvider {
    moduleNames.associate {
      it to ReactModuleInfo(
        name = it,
        className = it,
        canOverrideExistingModule = false,
        needsEagerInit = false,
        isCxxModule = false,
        isTurboModule = true
      )
    }
  }

  override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> =
    listOf(
      InlineInAppViewManager(reactContext)
    )

}
