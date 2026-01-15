package com.emarsys.reactnative.utils

import com.emarsys.mobileengage.api.inbox.Message
import com.emarsys.mobileengage.api.action.ActionModel
import com.emarsys.mobileengage.api.action.AppEventActionModel
import com.emarsys.mobileengage.api.action.OpenExternalUrlActionModel
import com.emarsys.mobileengage.api.action.CustomEventActionModel
import com.emarsys.mobileengage.api.action.DismissActionModel
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap

object InboxMessageUtils {

  fun convertMessageToMap(message: Message): WritableMap {
    val map = Arguments.createMap()
    MapUtils.put(map, "id", message.id)
    MapUtils.put(map, "campaignId", message.campaignId)
    MapUtils.put(map, "title", message.title)
    MapUtils.put(map, "body", message.body)
    MapUtils.put(map, "receivedAt", message.receivedAt)
    MapUtils.put(map, "collapseId", message.collapseId)
    MapUtils.put(map, "imageUrl", message.imageUrl)
    MapUtils.put(map, "updatedAt", message.updatedAt)
    MapUtils.put(map, "expiresAt", message.expiresAt)
    MapUtils.put(map, "tags", message.tags)
    MapUtils.put(map, "properties", message.properties)

    val actions = message.actions?.map { action -> convertActionToMap(action) }
    MapUtils.put(map, "actions", actions)

    return map
  }

  private fun convertActionToMap(action: ActionModel): WritableMap {
    val map = Arguments.createMap()

    MapUtils.put(map, "id", action.id)
    MapUtils.put(map, "title", action.title)
    MapUtils.put(map, "type", action.type)

    when (action) {
      is AppEventActionModel -> {
        MapUtils.put(map, "name", action.name)
        MapUtils.put(map, "payload", action.payload)
      }
      is OpenExternalUrlActionModel -> {
        MapUtils.put(map, "url", action.url)
      }
      is CustomEventActionModel -> {
        MapUtils.put(map, "name", action.name)
        MapUtils.put(map, "payload", action.payload)
      }
      is DismissActionModel -> {
        // no additional fields
      }
    }

    return map
  }
}
