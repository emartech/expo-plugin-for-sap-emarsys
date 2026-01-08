package com.emarsys.reactnative.utils

import android.content.Context
import com.emarsys.Emarsys
import com.emarsys.mobileengage.api.event.EventHandler
import org.json.JSONObject

object EventUtils {

  lateinit var eventsCache: MutableList<Map<String, Any?>>

  fun setEventHandler(eventHandler: EventHandler? = null) {
    val _eventHandler = eventHandler ?: EventHandler { context: Context, eventName: String, payload: JSONObject? ->
      if (!this::eventsCache.isInitialized) {
        eventsCache = mutableListOf()
      }
      eventsCache.add(mapOf("context" to context, "eventName" to eventName, "payload" to payload))
    }
    Emarsys.push.setNotificationEventHandler(_eventHandler)
    Emarsys.push.setSilentMessageEventHandler(_eventHandler)
    Emarsys.inApp.setEventHandler(_eventHandler)
    Emarsys.geofence.setEventHandler(_eventHandler)
    Emarsys.onEventAction.setOnEventActionEventHandler(_eventHandler)

    if (eventHandler != null && this::eventsCache.isInitialized) {
      for (event in eventsCache) {
        eventHandler.handleEvent(event["context"] as Context, event["eventName"] as String, event["payload"] as JSONObject?)
      }
      eventsCache.clear()
    }
  }

}
