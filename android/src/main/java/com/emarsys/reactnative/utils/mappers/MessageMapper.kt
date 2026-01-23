package com.emarsys.reactnative.utils.mappers

import com.emarsys.mobileengage.api.action.ActionModel
import com.emarsys.mobileengage.api.action.AppEventActionModel
import com.emarsys.mobileengage.api.action.OpenExternalUrlActionModel
import com.emarsys.mobileengage.api.inbox.Message
import com.emarsys.reactnative.utils.ArrayUtils.toWritableArray
import com.emarsys.reactnative.utils.MapUtils.put
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap

object MessageMapper {

  fun toWritableMap(message: Message): WritableMap {
    val writableMap = Arguments.createMap()
    writableMap.put("id", message.id)
    writableMap.put("campaignId", message.campaignId)
    writableMap.put("collapseId", message.collapseId)
    writableMap.put("title", message.title)
    writableMap.put("body", message.body)
    writableMap.put("imageUrl", message.imageUrl)
    writableMap.put("imageAltText", message.imageAltText)
    writableMap.put("receivedAt", message.receivedAt)
    writableMap.put("updatedAt", message.updatedAt)
    writableMap.put("expiresAt", message.expiresAt)
    writableMap.put("tags", message.tags)
    writableMap.put("properties", message.properties)
    writableMap.put("actions", message.actions?.toWritableArray(::toActionModelWritableMap))

    return writableMap
  }

  fun toActionModelWritableMap(actionModel: ActionModel): WritableMap {
    val writableMap = Arguments.createMap()
    writableMap.put("id", actionModel.id)
    writableMap.put("title", actionModel.title)
    writableMap.put("type", actionModel.type)

    when (actionModel) {
      is AppEventActionModel -> {
        writableMap.put("name", actionModel.name)
        writableMap.put("payload", actionModel.payload)
      }
      is OpenExternalUrlActionModel -> {
        writableMap.put("url", actionModel.url)
      }
      else -> {}
    }

    return writableMap
  }
}
