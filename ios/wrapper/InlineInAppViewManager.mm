#import <EmarsysSDK/EMSInlineInAppView.h>
#import <React/RCTUIManager.h>
#import <React/RCTViewComponentView.h>
#import <React/RCTViewManager.h>
#import <react/renderer/components/NativeEmarsys/ComponentDescriptors.h>
#import <react/renderer/components/NativeEmarsys/EventEmitters.h>
#import <react/renderer/components/NativeEmarsys/Props.h>
#import <react/renderer/components/NativeEmarsys/RCTComponentViewHelpers.h>

// Import FollyConvert.h based on React Native version
#if __has_include(<react/utils/FollyConvert.h>)
  #import <react/utils/FollyConvert.h>
#elif __has_include("FollyConvert.h")
  #import "FollyConvert.h"
#elif __has_include(<React/RCTFollyConvert.h>)
  #import <React/RCTFollyConvert.h>
#else
  #error "FollyConvert.h not found."
#endif

@interface InlineInAppViewManager : RCTViewManager
@end

@implementation InlineInAppViewManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(onEvent, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onCompletion, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onClose, RCTBubblingEventBlock)

@end

NS_ASSUME_NONNULL_BEGIN

@interface InlineInAppView : RCTViewComponentView

@end

NS_ASSUME_NONNULL_END

using namespace facebook::react;

@interface InlineInAppView () <RCTInlineInAppViewViewProtocol>
@end

@implementation InlineInAppView {
  EMSInlineInAppView *_view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider {
  return concreteComponentDescriptorProvider<InlineInAppViewComponentDescriptor>();
}

- (instancetype)init {
  if (self = [super init]) {
    _view = [[EMSInlineInAppView alloc] init];
    
    __weak InlineInAppView *weakSelf = self;
    _view.eventHandler = ^(NSString *eventName, NSDictionary<NSString *, id> *payload) {
      weakSelf.eventEmitter.onEvent(InlineInAppViewEventEmitter::OnEvent{
        .name = [eventName UTF8String],
        .payload = convertIdToFollyDynamic(payload)
      });
    };
    _view.completionBlock = ^(NSError *error) {
      weakSelf.eventEmitter.onCompletion(InlineInAppViewEventEmitter::OnCompletion{
        .error = error ? [error.localizedDescription UTF8String] : ""
      });
    };
    _view.closeBlock = ^ {
      weakSelf.eventEmitter.onClose(InlineInAppViewEventEmitter::OnClose{});
    };
    
    self.contentView = _view;
  }

  return self;
}

- (const InlineInAppViewEventEmitter &)eventEmitter {
  return static_cast<const InlineInAppViewEventEmitter &>(*_eventEmitter);
}

- (void)handleCommand:(const NSString *)commandName args:(const NSArray *)args {
  RCTInlineInAppViewHandleCommand(self, commandName, args);
}

- (void)loadInApp:(NSString *)viewId {
  [_view loadInAppWithViewId:viewId];
}

@end

Class<RCTComponentViewProtocol> InlineInAppViewCls(void) {
  return InlineInAppView.class;
}
