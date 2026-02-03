package com.emarsys.reactnative.utils.mappers

import com.emarsys.predict.api.model.Product
import com.emarsys.reactnative.utils.MapUtils
import com.facebook.react.bridge.JavaOnlyMap
import com.facebook.react.bridge.WritableMap
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.verify
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class ProductMapperTest {

  @Before
  fun setUp() {
    mockkStatic("com.facebook.react.bridge.Arguments")
    mockkObject(MapUtils)
    
    every { com.facebook.react.bridge.Arguments.createMap() } returns mockk(relaxed = true)
  }

  @Test
  fun test_toWritableMap() {
    val product = Product(
      productId = "testProductId",
      title = "testTitle",
      linkUrl = "https://www.testLinkUrl.com",
      feature = "testFeature",
      cohort = "testCohort",
      customFields = mapOf("testK1" to "testV1", "testK2" to "testV2"),
      imageUrlString = "https://www.testImageUrl.com",
      zoomImageUrlString = "https://www.testZoomImageUrl.com",
      categoryPath = "testCategoryPath",
      available = true,
      productDescription = "testProductDescription",
      price = 12.34f,
      msrp = 56.78f,
      album = "testAlbum",
      actor = "testActor",
      artist = "testArtist",
      author = "testAuthor",
      brand = "testBrand",
      year = 999
    )

    val result = ProductMapper.toWritableMap(product)

    verify { result.putString("productId", "testProductId") }
    verify { result.putString("title", "testTitle") }
    verify { result.putString("linkUrl", "https://www.testLinkUrl.com") }
    verify { result.putString("feature", "testFeature") }
    verify { result.putString("cohort", "testCohort") }
    val customFieldsSlot = slot<WritableMap>()
    verify { result.putMap("customFields", capture(customFieldsSlot)) }
    verify { customFieldsSlot.captured.putString("testK1", "testV1") }
    verify { customFieldsSlot.captured.putString("testK2", "testV2") }
    verify { result.putString("imageUrl", "https://www.testImageUrl.com") }
    verify { result.putString("zoomImageUrl", "https://www.testZoomImageUrl.com") }
    verify { result.putString("categoryPath", "testCategoryPath") }
    verify { result.putBoolean("available", true) }
    verify { result.putString("productDescription", "testProductDescription") }
    verify { result.putDouble("price", (12.34f).toDouble()) }
    verify { result.putDouble("msrp", (56.78f).toDouble()) }
    verify { result.putString("album", "testAlbum") }
    verify { result.putString("actor", "testActor") }
    verify { result.putString("artist", "testArtist") }
    verify { result.putString("author", "testAuthor") }
    verify { result.putString("brand", "testBrand") }
    verify { result.putInt("year", 999) }
  }

  @Test
  fun test_toModel() {
    val map = JavaOnlyMap.of(
      "productId", "testProductId",
      "title", "testTitle",
      "linkUrl", "https://www.testLinkUrl.com",
      "feature", "testFeature",
      "cohort", "testCohort",
      "customFields", JavaOnlyMap.of("testK1", "testV1", "testK2", "testV2"),
      "imageUrl", "https://www.testImageUrl.com",
      "zoomImageUrl", "https://www.testZoomImageUrl.com",
      "categoryPath", "testCategoryPath",
      "available", true,
      "productDescription", "testProductDescription",
      "price", 12.34,
      "msrp", 56.78,
      "album", "testAlbum",
      "actor", "testActor",
      "artist", "testArtist",
      "author", "testAuthor",
      "brand", "testBrand",
      "year", 999
    )

    val result = ProductMapper.toModel(map)

    Assert.assertNotNull(result)
    Assert.assertEquals(result!!.productId, "testProductId")
    Assert.assertEquals(result!!.title, "testTitle")
    Assert.assertEquals(result!!.linkUrl, "https://www.testLinkUrl.com")
    Assert.assertEquals(result!!.feature, "testFeature")
    Assert.assertEquals(result!!.cohort, "testCohort")
    Assert.assertEquals(result!!.customFields, mapOf("testK1" to "testV1", "testK2" to "testV2"))
    Assert.assertEquals(result!!.imageUrl.toString(), "https://www.testImageUrl.com")
    Assert.assertEquals(result!!.zoomImageUrl.toString(), "https://www.testZoomImageUrl.com")
    Assert.assertEquals(result!!.categoryPath, "testCategoryPath")
    Assert.assertEquals(result!!.available, true)
    Assert.assertEquals(result!!.productDescription, "testProductDescription")
    Assert.assertEquals(result!!.price!!.toDouble(), 12.34, 0.1)
    Assert.assertEquals(result!!.msrp!!.toDouble(), 56.78, 0.1)
    Assert.assertEquals(result!!.album, "testAlbum")
    Assert.assertEquals(result!!.actor, "testActor")
    Assert.assertEquals(result!!.artist, "testArtist")
    Assert.assertEquals(result!!.author, "testAuthor")
    Assert.assertEquals(result!!.brand, "testBrand")
    Assert.assertEquals(result!!.year, 999)
  }

  @Test
  fun test_toModel_null() {
    val result = ProductMapper.toModel(null)

    Assert.assertNull(result)
  }

}
