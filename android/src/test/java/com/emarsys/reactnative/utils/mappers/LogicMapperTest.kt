package com.emarsys.reactnative.utils.mappers

import com.facebook.react.bridge.JavaOnlyArray
import com.facebook.react.bridge.JavaOnlyMap
import org.junit.Assert
import org.junit.Test

class LogicMapperTest {

  @Test
  fun test_toModel_search() {
    val map = JavaOnlyMap.of(
      "name", "SEARCH"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "SEARCH")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_searchWithData() {
    val map = JavaOnlyMap.of(
      "name", "SEARCH",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "SEARCH")
    Assert.assertEquals(result!!.data, mapOf("q" to "testQuery"))
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_cart() {
    val map = JavaOnlyMap.of(
      "name", "CART"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "CART")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_cartWithData() {
    val map = JavaOnlyMap.of(
      "name", "CART",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "CART")
    Assert.assertEquals(result!!.data, mapOf(
      "cv" to "1",
      "ca" to "i:testId,p:12.34,q:56.78"
    ))
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_related() {
    val map = JavaOnlyMap.of(
      "name", "RELATED"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "RELATED")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_relatedWithData() {
    val map = JavaOnlyMap.of(
      "name", "RELATED",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "RELATED")
    Assert.assertEquals(result!!.data, mapOf("v" to "i:testQuery"))
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_category() {
    val map = JavaOnlyMap.of(
      "name", "CATEGORY"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "CATEGORY")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_categoryWithData() {
    val map = JavaOnlyMap.of(
      "name", "CATEGORY",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "CATEGORY")
    Assert.assertEquals(result!!.data, mapOf("vc" to "testQuery"))
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_alsoBought() {
    val map = JavaOnlyMap.of(
      "name", "ALSO_BOUGHT"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "ALSO_BOUGHT")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_alsoBoughtWithData() {
    val map = JavaOnlyMap.of(
      "name", "ALSO_BOUGHT",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "ALSO_BOUGHT")
    Assert.assertEquals(result!!.data, mapOf("v" to "i:testQuery"))
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_popular() {
    val map = JavaOnlyMap.of(
      "name", "POPULAR"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "POPULAR")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_popularWithData() {
    val map = JavaOnlyMap.of(
      "name", "POPULAR",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "POPULAR")
    Assert.assertEquals(result!!.data, mapOf("vc" to "testQuery"))
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_personal() {
    val map = JavaOnlyMap.of(
      "name", "PERSONAL"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "PERSONAL")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_personalWithData() {
    val map = JavaOnlyMap.of(
      "name", "PERSONAL",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "PERSONAL")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf("test1", "test2"))
  }

  @Test
  fun test_toModel_home() {
    val map = JavaOnlyMap.of(
      "name", "HOME"
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "HOME")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf<String>())
  }

  @Test
  fun test_toModel_homeWithData() {
    val map = JavaOnlyMap.of(
      "name", "HOME",
      "query", "testQuery",
      "cartItems", JavaOnlyArray.of(JavaOnlyMap.of(
        "itemId", "testId",
        "price", 12.34,
        "quantity", 56.78
      )),
      "variants", JavaOnlyArray.of("test1", "test2")
    )

    val result = LogicMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.logicName, "HOME")
    Assert.assertEquals(result!!.data, mapOf<String, String>())
    Assert.assertEquals(result!!.variants, listOf("test1", "test2"))
  }

  @Test
  fun test_toModel_null() {
    val result = LogicMapper.toModel(null)

    Assert.assertNull(result)
  }

}
