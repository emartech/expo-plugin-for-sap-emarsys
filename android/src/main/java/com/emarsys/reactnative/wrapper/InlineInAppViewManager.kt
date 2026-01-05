package com.emarsys.reactnative.wrapper

import android.view.ViewGroup
import android.widget.LinearLayout
import com.emarsys.core.api.result.CompletionListener
import com.emarsys.reactnative.utils.MapUtils
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContext
import com.facebook.react.bridge.WritableMap
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.events.Event
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.UIManagerHelper
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.viewmanagers.InlineInAppViewManagerDelegate
import com.facebook.react.viewmanagers.InlineInAppViewManagerInterface
import org.json.JSONObject

@ReactModule(name = InlineInAppViewManager.NAME)
class InlineInAppViewManager(context: ReactApplicationContext) : SimpleViewManager<InlineInAppView>(), InlineInAppViewManagerInterface<InlineInAppView> {

  companion object {
    const val NAME = "InlineInAppView"
  }

  private val delegate: InlineInAppViewManagerDelegate<InlineInAppView, InlineInAppViewManager> = InlineInAppViewManagerDelegate(this)

  override fun getName(): String = NAME

  override fun getDelegate(): ViewManagerDelegate<InlineInAppView> = delegate

  override fun createViewInstance(context: ThemedReactContext): InlineInAppView {
    val view = InlineInAppView(context)

    view.inlineInAppView.onAppEventListener = { property: String?, json: JSONObject ->
      dispatchEvent(view, "onEvent", Arguments.createMap().apply {
        putString("name", property)
        putMap("payload", MapUtils.toWritableMap(json)?.getMap("payload"))
      })
    }
    view.inlineInAppView.onCompletionListener = CompletionListener { errorCause: Throwable? ->
      dispatchEvent(view, "onCompletion", Arguments.createMap().apply {
        putString("error", errorCause?.localizedMessage ?: "")
      })
    }
    view.inlineInAppView.onCloseListener = {
      dispatchEvent(view, "onClose", Arguments.createMap())
    }

    return view
  }

  override fun getExportedCustomBubblingEventTypeConstants(): Map<String, Any> =
    mapOf(
      "onEvent"       to mapOf("phasedRegistrationNames" to mapOf("bubbled" to "onEvent")),
      "onCompletion"  to mapOf("phasedRegistrationNames" to mapOf("bubbled" to "onCompletion")),
      "onClose"       to mapOf("phasedRegistrationNames" to mapOf("bubbled" to "onClose"))
    )

  fun dispatchEvent(view: InlineInAppView, name: String, data: WritableMap?) {
    val reactContext = view.context as ReactContext
    val surfaceId = UIManagerHelper.getSurfaceId(reactContext)
    val eventDispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, view.id)
    eventDispatcher?.dispatchEvent(EMSEvent(surfaceId, view.id, name, data))
  }

  inner class EMSEvent(surfaceId: Int, viewTag: Int, private val name: String, private val data: WritableMap?) : Event<EMSEvent>(surfaceId, viewTag) {
    override fun getEventName() = name
    override fun getEventData() = data
  }

  override fun loadInApp(view: InlineInAppView, viewId: String) {
    view.inlineInAppView.loadInApp(viewId)
  }

}

class InlineInAppView : LinearLayout {

  val inlineInAppView: com.emarsys.inapp.ui.InlineInAppView

  constructor(context: ThemedReactContext) : super(context) {
    inlineInAppView = com.emarsys.inapp.ui.InlineInAppView(context, ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    inlineInAppView.setLayoutParams(LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT))
    addView(inlineInAppView)
  }

  // Native components do not re-layout properly, width and height remain 0 .
  // Workaround based on:
  // https://github.com/facebook/react-native/issues/4990
  // https://github.com/facebook/react-native/issues/17968

  override fun requestLayout() {
    super.requestLayout()
    post(measureAndLayout)
  }

  private val measureAndLayout = Runnable {
    measure(MeasureSpec.makeMeasureSpec(width, MeasureSpec.EXACTLY), MeasureSpec.makeMeasureSpec(height, MeasureSpec.EXACTLY))
    layout(left, top, right, bottom)
  }

}
