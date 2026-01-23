package com.emarsys.reactnative.wrapper

import com.emarsys.core.api.result.Try
import com.emarsys.Emarsys
import com.emarsys.mobileengage.api.inbox.InboxResult
import com.emarsys.reactnative.utils.ArrayUtils.toWritableArray
import com.emarsys.reactnative.utils.mappers.MessageMapper
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class NativeEmarsysInbox(reactContext: ReactApplicationContext) : NativeEmarsysInboxSpec(reactContext) {

  companion object {
    const val NAME = "NativeEmarsysInbox"
  }

  override fun getName() = NAME

  override fun fetchMessages(promise: Promise) {
    try {
      Emarsys.messageInbox.fetchMessages { result: Try<InboxResult> ->
        if (result.errorCause == null) {
          val messages = result.result?.messages?.toWritableArray(MessageMapper::toWritableMap)
          promise.resolve(messages)
        } else {
          promise.reject(NAME, "fetchMessages", result.errorCause)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "fetchMessages", e)
    }
  }

  override fun addTag(tag: String, messageId: String, promise: Promise) {
    try {
      Emarsys.messageInbox.addTag(tag, messageId) { errorCause: Throwable? ->
        if (errorCause == null) {
          promise.resolve(null)
        } else {
          promise.reject(NAME, "addTag", errorCause)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "addTag", e)
    }
  }

  override fun removeTag(tag: String, messageId: String, promise: Promise) {
    try {
      Emarsys.messageInbox.removeTag(tag, messageId) { errorCause: Throwable? ->
        if (errorCause == null) {
          promise.resolve(null)
        } else {
          promise.reject(NAME, "removeTag", errorCause)
        }
      }
    } catch (e: Exception) {
      promise.reject(NAME, "removeTag", e)
    }
  }

}
