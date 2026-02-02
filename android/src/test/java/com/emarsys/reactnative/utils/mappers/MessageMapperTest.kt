package com.emarsys.reactnative.utils.mappers

import com.emarsys.mobileengage.api.action.AppEventActionModel
import com.emarsys.mobileengage.api.action.CustomEventActionModel
import com.emarsys.mobileengage.api.action.OpenExternalUrlActionModel
import com.emarsys.mobileengage.api.inbox.Message
import com.emarsys.reactnative.utils.ArrayUtils
import com.emarsys.reactnative.utils.MapUtils
import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import java.net.URL

class MessageMapperTest {

  @Before
  fun setUp() {
    mockkStatic("com.facebook.react.bridge.Arguments")
    mockkObject(MapUtils)
    
    every { com.facebook.react.bridge.Arguments.createMap() } returns mockk(relaxed = true)
    every { com.facebook.react.bridge.Arguments.createArray() } returns mockk(relaxed = true)
  }

  @Test
  fun test_toWritableMapWithMessage() {
    val message = Message(
      "testId",
      "testCampaignId",
      "testCollapseId",
      "testTitle",
      "testBody",
      "testImageUrl",
      "testImageAltText",
      1234,
      4321,
      5678,
      listOf("TAG1", "TAG2", "TAG3"),
      mapOf("k1" to "v1", "k2" to "v2"),
      listOf(
        AppEventActionModel(
          "actionId1",
          "actionTitle1",
          "MEAppEvent",
          "actionName1",
          mapOf("key11" to "value", "key12" to 123)
        ),
        CustomEventActionModel(
          "actionId2",
          "actionTitle2",
          "MECustomEvent",
          "actionName2",
          mapOf("key21" to "value", "key22" to 456)
        ),
        OpenExternalUrlActionModel(
          "actionId4",
          "actionTitle4",
          "OpenExternalUrl",
          URL("https://www.emarsys.com")
        )
      )
    )

    val result = MessageMapper.toWritableMap(message)

    verify { result.putString("id", "testId") }
    verify { result.putString("campaignId", "testCampaignId") }
    verify { result.putString("collapseId", "testCollapseId") }
    verify { result.putString("title", "testTitle") }
    verify { result.putString("body", "testBody") }
    verify { result.putString("imageUrl", "testImageUrl") }
    verify { result.putString("imageAltText", "testImageAltText") }
    verify { result.putLong("receivedAt", 1234) }
    verify { result.putLong("updatedAt", 4321) }
    verify { result.putLong("expiresAt", 5678) }
    
    val tagsSlot = slot<WritableArray>()
    verify { result.putArray("tags", capture(tagsSlot)) }
    verify(exactly = 3) { tagsSlot.captured.pushString(any()) }
    
    val propertiesSlot = slot<WritableMap>()
    verify { result.putMap("properties", capture(propertiesSlot)) }
    verify { propertiesSlot.captured.putString("k1", "v1") }
    verify { propertiesSlot.captured.putString("k2", "v2") }
    
    val actionsSlot = slot<WritableArray>()
    verify { result.putArray("actions", capture(actionsSlot)) }
    
    val actionMaps = mutableListOf<WritableMap>()
    verify(exactly = 3) { actionsSlot.captured.pushMap(capture(actionMaps)) }
    
    val action1 = actionMaps[0]
    verify { action1.putString("id", "actionId1") }
    verify { action1.putString("title", "actionTitle1") }
    verify { action1.putString("type", "MEAppEvent") }
    verify { action1.putString("name", "actionName1") }
    verify { action1.putMap("payload", any()) }
    
    val action2 = actionMaps[1]
    verify { action2.putString("id", "actionId2") }
    verify { action2.putString("title", "actionTitle2") }
    verify { action2.putString("type", "MECustomEvent") }
    
    val action3 = actionMaps[2]
    verify { action3.putString("id", "actionId4") }
    verify { action3.putString("title", "actionTitle4") }
    verify { action3.putString("type", "OpenExternalUrl") }
    verify { action3.putString("url", "https://www.emarsys.com") }
  }

  @Test
  fun test_toActionModelWritableMapWithAppEventActionModel() {
    val appEventAction = AppEventActionModel(
      "action1",
      "Action Title",
      "MEAppEvent",
      "event_name",
      mapOf("key1" to "value1")
    )

    val result = MessageMapper.toActionModelWritableMap(appEventAction)

    verify { result.putString("id", "action1") }
    verify { result.putString("title", "Action Title") }
    verify { result.putString("type", "MEAppEvent") }
    verify { result.putString("name", "event_name") }
  }

  @Test
  fun test_toActionModelWritableMapWithOpenExternalUrlActionModel() {
    val openExternalUrlAction = OpenExternalUrlActionModel(
      "action2",
      "Action Title 2",
      "OpenExternalUrl",
      URL("https://example.com")
    )

    val result = MessageMapper.toActionModelWritableMap(openExternalUrlAction)

    verify { result.putString("id", "action2") }
    verify { result.putString("title", "Action Title 2") }
    verify { result.putString("type", "OpenExternalUrl") }
    verify { result.putString("url", "https://example.com") }
  }
}
