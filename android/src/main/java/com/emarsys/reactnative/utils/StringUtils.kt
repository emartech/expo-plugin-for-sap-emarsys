package com.emarsys.reactnative.utils

object StringUtils {

  fun String.splitAndTrim(delimiter: String = ","): List<String> {
    return this
      .split(delimiter)
      .map { it.trim() }
      .filter { it.isNotEmpty() }
  }

}
