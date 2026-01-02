import ExpoModulesCore
import EmarsysSDK
import RNEmarsysWrapper

public class EmarsysAppDelegateSubscriber: ExpoAppDelegateSubscriber {

  public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let config = StorageUtils.getEMSConfig()!
    Emarsys.setup(config: config)

    UNUserNotificationCenter.current().delegate = Emarsys.push
    let rnEmarsysEventHandler = RNEmarsysEventHandler()
    rnEmarsysEventHandler.setEventHandlers()

    return true
  }

  public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Emarsys.push.setPushToken(deviceToken)
  }

}
