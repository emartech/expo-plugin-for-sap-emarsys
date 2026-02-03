package com.emarsys.reactnative.utils.mappers

import com.emarsys.mobileengage.api.geofence.Geofence
import com.emarsys.mobileengage.api.geofence.Trigger
import com.emarsys.mobileengage.api.geofence.TriggerType
import com.emarsys.reactnative.utils.MapUtils
import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.verify
import org.json.JSONObject
import org.junit.Before
import org.junit.Test

class GeofenceMapperTest {

  private lateinit var actionMap1: WritableMap
  private lateinit var actionMap2: WritableMap

  @Before
  fun setUp() {
    mockkStatic("com.facebook.react.bridge.Arguments")
    mockkObject(MapUtils)
    
    every { com.facebook.react.bridge.Arguments.createMap() } returns mockk(relaxed = true)
    every { com.facebook.react.bridge.Arguments.createArray() } returns mockk(relaxed = true)
    
    actionMap1 = mockk(relaxed = true)
    actionMap2 = mockk(relaxed = true)
  }

  @Test
  fun test_toWritableMapWithGeofence() {
    val actionJson1 = JSONObject(mapOf("k1" to "v1"))
    val actionJson2 = JSONObject(mapOf("k1" to "v1", "k2" to "v2"))
    
    every { with(MapUtils) { actionJson1.toWritableMap() } } answers {
      actionMap1.putString("k1", "v1")
      actionMap1
    }
    every { with(MapUtils) { actionJson2.toWritableMap() } } answers {
      actionMap2.putString("k1", "v1")
      actionMap2.putString("k2", "v2")
      actionMap2
    }
    
    val geofence = Geofence(
      "testGeofenceId",
      12.34,
      56.78,
      30.0,
      90.12,
      listOf(
        Trigger("testTriggerId", TriggerType.ENTER, 123, actionJson1),
        Trigger("testTriggerId2", TriggerType.EXIT, 456, actionJson2)
      )
    )

    val result = GeofenceMapper.toWritableMap(geofence)

    verify { result.putString("id", "testGeofenceId") }
    verify { result.putDouble("lat", 12.34) }
    verify { result.putDouble("lon", 56.78) }
    verify { result.putDouble("radius", 30.0) }
    verify { result.putDouble("waitInterval", 90.12) }

    val triggersSlot = slot<WritableArray>()
    verify { result.putArray("triggers", capture(triggersSlot)) }
    
    val triggerMaps = mutableListOf<WritableMap>()
    verify(exactly = 2) { triggersSlot.captured.pushMap(capture(triggerMaps)) }
    
    val triggerResult1 = triggerMaps[0]
    verify { triggerResult1.putString("id", "testTriggerId") }
    verify { triggerResult1.putString("type", "ENTER") }
    verify { triggerResult1.putInt("loiteringDelay", 123) }
    verify { triggerResult1.putMap("action", actionMap1) }
    
    verify { actionMap1.putString("k1", "v1") }

    val triggerResult2 = triggerMaps[1]
    verify { triggerResult2.putString("id", "testTriggerId2") }
    verify { triggerResult2.putString("type", "EXIT") }
    verify { triggerResult2.putInt("loiteringDelay", 456) }
    verify { triggerResult2.putMap("action", actionMap2) }
    
    verify { actionMap2.putString("k1", "v1") }
    verify { actionMap2.putString("k2", "v2") }
  }

  @Test
  fun test_toTriggerWritableMap() {
    val actionJson = JSONObject(mapOf("key" to "value"))
    val actionMap = mockk<WritableMap>(relaxed = true)
    
    every { with(MapUtils) { actionJson.toWritableMap() } } answers {
      actionMap.putString("key", "value")
      actionMap
    }
    
    val trigger = Trigger("triggerId", TriggerType.ENTER, 100, actionJson)
    
    val result = GeofenceMapper.toTriggerWritableMap(trigger)
    
    verify { result.putString("id", "triggerId") }
    verify { result.putString("type", "ENTER") }
    verify { result.putInt("loiteringDelay", 100) }
    verify { result.putMap("action", actionMap) }
    verify { actionMap.putString("key", "value") }
  }
}
