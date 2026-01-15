#import "InboxMessageUtils.h"
#import <EmarsysSDK/EMSAppEventActionModel.h>
#import <EmarsysSDK/EMSOpenExternalUrlActionModel.h>
#import <EmarsysSDK/EMSCustomEventActionModel.h>

@implementation InboxMessageUtils

+ (NSMutableDictionary *)messageToMap:(EMSMessage *)message {
    NSMutableDictionary<NSString *, NSObject *> *map = [[NSMutableDictionary alloc] init];

    map[@"id"] = message.id;
    map[@"campaignId"] = message.campaignId;
    map[@"collapseId"] = message.collapseId;
    map[@"title"] = message.title;
    map[@"body"] = message.body;
    map[@"imageUrl"] = message.imageUrl;
    map[@"receivedAt"] = message.receivedAt;
    map[@"updatedAt"] = message.updatedAt;
    map[@"expiresAt"] = message.expiresAt;
    map[@"tags"] = message.tags;
    map[@"properties"] = message.properties;

    NSMutableArray *actions = [NSMutableArray array];
    for (id<EMSActionModelProtocol> messageAction in message.actions) {
        NSMutableDictionary<NSString *, NSString *> *action = [InboxMessageUtils actionToMap:messageAction];
        [actions addObject:action];
    }
    map[@"actions"] = actions;

    return map;
}

+ (NSMutableDictionary *)actionToMap:(id<EMSActionModelProtocol>)action {
    NSMutableDictionary<NSString *, NSObject *> *map = [[NSMutableDictionary alloc] init];

    map[@"id"] = action.id;
    map[@"title"] = action.title;
    map[@"type"] = action.type;

    if ([action isKindOfClass:[EMSAppEventActionModel class]]) {
        EMSAppEventActionModel *appEventAction = (EMSAppEventActionModel *)action;
        map[@"name"] = appEventAction.name;
        map[@"payload"] = appEventAction.payload;
    } else if ([action isKindOfClass:[EMSOpenExternalUrlActionModel class]]) {
        EMSOpenExternalUrlActionModel *urlAction = (EMSOpenExternalUrlActionModel *)action;
        map[@"url"] = urlAction.url;
    } else if ([action isKindOfClass:[EMSCustomEventActionModel class]]) {
        EMSCustomEventActionModel *customEventAction = (EMSCustomEventActionModel *)action;
        map[@"name"] = customEventAction.name;
        map[@"payload"] = customEventAction.payload;
    }

    return map;
}

@end
