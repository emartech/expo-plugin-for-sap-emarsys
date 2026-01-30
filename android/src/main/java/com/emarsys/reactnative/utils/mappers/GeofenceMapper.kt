package com.emarsys.reactnative.utils.mappers

import com.emarsys.mobileengage.api.geofence.Geofence
import com.emarsys.mobileengage.api.geofence.Trigger
import com.emarsys.reactnative.utils.ArrayUtils.toWritableArray
import com.emarsys.reactnative.utils.MapUtils.put
import com.emarsys.reactnative.utils.MapUtils.toWritableMap
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap

object GeofenceMapper {

  fun toWritableMap(geofence: Geofence): WritableMap {
    val writableMap = Arguments.createMap()
    writableMap.put("id", geofence.id)
    writableMap.put("lat", geofence.lat)
    writableMap.put("lon", geofence.lon)
    writableMap.put("radius", geofence.radius)
    writableMap.put("waitInterval", geofence.waitInterval)
    writableMap.put("triggers", geofence.triggers.toWritableArray(::toTriggerWritableMap))

    return writableMap
  }

  fun toTriggerWritableMap(trigger: Trigger): WritableMap {
    val writableMap = Arguments.createMap()
    writableMap.put("id", trigger.id)
    writableMap.put("type", trigger.type.name)
    writableMap.put("loiteringDelay", trigger.loiteringDelay)
    writableMap.put("action", trigger.action.toWritableMap())

    return writableMap
  }

}
