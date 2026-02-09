package com.emarsys.reactnative.utils.mappers

import com.facebook.react.bridge.JavaOnlyArray
import com.facebook.react.bridge.JavaOnlyMap
import org.junit.Assert
import org.junit.Test

class FilterMapperTest {

  @Test
  fun test_toModel_includeIs() {
    val map = JavaOnlyMap.of(
      "type", "INCLUDE",
      "field", "testField",
      "comparison", "IS",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "INCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "IS")
    Assert.assertEquals(result!!.expectations, listOf("test1"))
  }

  @Test
  fun test_toModel_includeIn() {
    val map = JavaOnlyMap.of(
      "type", "INCLUDE",
      "field", "testField",
      "comparison", "IN",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "INCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "IN")
    Assert.assertEquals(result!!.expectations, listOf("test1", "test2"))
  }

  @Test
  fun test_toModel_includeHas() {
    val map = JavaOnlyMap.of(
      "type", "INCLUDE",
      "field", "testField",
      "comparison", "HAS",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "INCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "HAS")
    Assert.assertEquals(result!!.expectations, listOf("test1"))
  }

  @Test
  fun test_toModel_includeOverlaps() {
    val map = JavaOnlyMap.of(
      "type", "INCLUDE",
      "field", "testField",
      "comparison", "OVERLAPS",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "INCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "OVERLAPS")
    Assert.assertEquals(result!!.expectations, listOf("test1", "test2"))
  }

  @Test
  fun test_toModel_excludeIs() {
    val map = JavaOnlyMap.of(
      "type", "EXCLUDE",
      "field", "testField",
      "comparison", "IS",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "EXCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "IS")
    Assert.assertEquals(result!!.expectations, listOf("test1"))
  }

  @Test
  fun test_toModel_excludeIn() {
    val map = JavaOnlyMap.of(
      "type", "EXCLUDE",
      "field", "testField",
      "comparison", "IN",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "EXCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "IN")
    Assert.assertEquals(result!!.expectations, listOf("test1", "test2"))
  }

  @Test
  fun test_toModel_excludeHas() {
    val map = JavaOnlyMap.of(
      "type", "EXCLUDE",
      "field", "testField",
      "comparison", "HAS",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "EXCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "HAS")
    Assert.assertEquals(result!!.expectations, listOf("test1"))
  }

  @Test
  fun test_toModel_excludeOverlaps() {
    val map = JavaOnlyMap.of(
      "type", "EXCLUDE",
      "field", "testField",
      "comparison", "OVERLAPS",
      "expectations", JavaOnlyArray.of("test1", "test2")
    )

    val result = FilterMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.type, "EXCLUDE")
    Assert.assertEquals(result!!.field, "testField")
    Assert.assertEquals(result!!.comparison, "OVERLAPS")
    Assert.assertEquals(result!!.expectations, listOf("test1", "test2"))
  }

  @Test
  fun test_toModel_null() {
    val result = FilterMapper.toModel(null)

    Assert.assertNull(result)
  }

}
