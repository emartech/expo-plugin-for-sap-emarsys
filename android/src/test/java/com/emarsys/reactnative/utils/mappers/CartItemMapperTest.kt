package com.emarsys.reactnative.utils.mappers

import com.facebook.react.bridge.JavaOnlyMap
import org.junit.Assert
import org.junit.Test

class CartItemMapperTest {

  @Test
  fun test_toModel() {
    val map = JavaOnlyMap.of(
      "itemId", "testId",
      "price", 12.34,
      "quantity", 56.78
    )

    val result = CartItemMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.itemId, "testId")
    Assert.assertEquals(result!!.price, 12.34, 0.1)
    Assert.assertEquals(result!!.quantity, 56.78, 0.1)
  }

  @Test
  fun test_toModel_null() {
    val result = CartItemMapper.toModel(null)

    Assert.assertNull(result)
  }

}
