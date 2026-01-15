package com.emarsys.reactnative.utils.mappers

import com.emarsys.predict.api.model.Product
import com.emarsys.reactnative.utils.MapUtils.put
import com.emarsys.reactnative.utils.MapUtils.toStringMap
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableMap

object ProductMapper {

  fun toWritableMap(product: Product): WritableMap {
    val writableMap = Arguments.createMap();
    writableMap.put("productId", product.productId);
    writableMap.put("title", product.title);
    writableMap.put("linkUrl", product.linkUrl);
    writableMap.put("feature", product.feature);
    writableMap.put("cohort", product.cohort);
    writableMap.put("customFields", product.customFields);
    writableMap.put("imageUrl", product.imageUrl);
    writableMap.put("zoomImageUrl", product.zoomImageUrl);
    writableMap.put("categoryPath", product.categoryPath);
    writableMap.put("available", product.available);
    writableMap.put("productDescription", product.productDescription);
    writableMap.put("price", product.price);
    writableMap.put("msrp", product.msrp);
    writableMap.put("album", product.album);
    writableMap.put("actor", product.actor);
    writableMap.put("artist", product.artist);
    writableMap.put("author", product.author);
    writableMap.put("brand", product.brand);
    writableMap.put("year", product.year);

    return writableMap;
  }

  fun toModel(readableMap: ReadableMap?): Product? {
    if (readableMap == null) {
      return null
    }

    return Product(
      productId = readableMap.getString("productId")!!,
      title = readableMap.getString("title")!!,
      linkUrl = readableMap.getString("linkUrl")!!,
      feature = readableMap.getString("feature")!!,
      cohort = readableMap.getString("cohort")!!,
      customFields = readableMap.getMap("customFields")!!.toStringMap(),
      imageUrlString = readableMap.getString("imageUrl"), // imageUrl
      zoomImageUrlString = readableMap.getString("zoomImageUrl"), // zoomImageUrl
      categoryPath = readableMap.getString("categoryPath"),
      available = if (readableMap.hasKey("available") && !readableMap.isNull("available")) readableMap.getBoolean("available") else null,
      productDescription = readableMap.getString("productDescription"),
      price = if (readableMap.hasKey("price") && !readableMap.isNull("price")) readableMap.getDouble("price").toFloat() else null,
      msrp = if (readableMap.hasKey("msrp") && !readableMap.isNull("msrp")) readableMap.getDouble("msrp").toFloat() else null,
      album = readableMap.getString("album"),
      actor = readableMap.getString("actor"),
      artist = readableMap.getString("artist"),
      author = readableMap.getString("author"),
      brand = readableMap.getString("brand"),
      year = if (readableMap.hasKey("year") && !readableMap.isNull("year")) readableMap.getInt("year") else null
    )
  }

}
