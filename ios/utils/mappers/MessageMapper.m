#import "MessageMapper.h"

@implementation MessageMapper

static Mapper _toDictionary = ^NSDictionary *(EMSMessage *message) {
  NSMutableDictionary<NSString *, NSObject *> *dictionary = [NSMutableDictionary dictionary];
  dictionary[@"id"] = message.id;
  dictionary[@"campaignId"] = message.campaignId;
  dictionary[@"collapseId"] = message.collapseId;
  dictionary[@"title"] = message.title;
  dictionary[@"body"] = message.body;
  dictionary[@"imageUrl"] = message.imageUrl;
  dictionary[@"imageAltText"] = message.imageAltText;
  dictionary[@"receivedAt"] = message.receivedAt;
  dictionary[@"updatedAt"] = message.updatedAt;
  dictionary[@"expiresAt"] = message.expiresAt;
  dictionary[@"tags"] = message.tags;
  dictionary[@"properties"] = message.properties;
  dictionary[@"actions"] = [message.actions map:MessageMapper.toActionModelDictionary];

  return dictionary;
};

+ (Mapper)toDictionary {
  return _toDictionary;
}

static Mapper _toActionModelDictionary = ^NSDictionary *(id<EMSActionModelProtocol> actionModel) {
  NSMutableDictionary<NSString *, NSObject *> *dictionary = [NSMutableDictionary dictionary];
  dictionary[@"id"] = actionModel.id;
  dictionary[@"title"] = actionModel.title;
  dictionary[@"type"] = actionModel.type;

  if ([actionModel isKindOfClass:[EMSAppEventActionModel class]]) {
    EMSAppEventActionModel *appEventActionModel = (EMSAppEventActionModel *)actionModel;
    dictionary[@"name"] = appEventActionModel.name;
    dictionary[@"payload"] = appEventActionModel.payload;
  } else if ([actionModel isKindOfClass:[EMSOpenExternalUrlActionModel class]]) {
    EMSOpenExternalUrlActionModel *externalUrlActionModel = (EMSOpenExternalUrlActionModel *)actionModel;
    dictionary[@"url"] = externalUrlActionModel.url.absoluteString;
  }

  return dictionary;
};

+ (Mapper)toActionModelDictionary {
  return _toActionModelDictionary;
}

@end
