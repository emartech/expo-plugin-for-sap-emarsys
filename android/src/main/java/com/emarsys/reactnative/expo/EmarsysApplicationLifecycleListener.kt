package com.emarsys.reactnative.expo

import android.app.Application
import com.emarsys.Emarsys
import com.emarsys.reactnative.utils.StorageUtils
import com.emarsys.rnwrapper.RNEmarsysEventHandler
import expo.modules.core.interfaces.ApplicationLifecycleListener

class EmarsysApplicationLifecycleListener(): ApplicationLifecycleListener {

  override fun onCreate(application: Application) {
    super.onCreate(application)

    val config = StorageUtils.getEmarsysConfig(application)
    Emarsys.setup(config)

    val eventHandler = RNEmarsysEventHandler.getInstance()
    eventHandler.setEventHandlers()
  }

}
