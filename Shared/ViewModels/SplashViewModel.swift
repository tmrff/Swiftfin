//
 /* 
  * SwiftFin is subject to the terms of the Mozilla Public
  * License, v2.0. If a copy of the MPL was not distributed with this
  * file, you can obtain one at https://mozilla.org/MPL/2.0/.
  *
  * Copyright 2021 Aiden Vigue & Jellyfin Contributors
  */

import Foundation
import Combine
import Nuke
import UIKit

#if !os(tvOS)
import WidgetKit
#endif

final class SplashViewModel: ViewModel {

    @Published var isLoggedIn: Bool = false

    override init() {
        // TODO: Remove SplashViewModel
        isLoggedIn = SessionManager.main.currentLogin != nil
        super.init()

        ImageCache.shared.costLimit = 125 * 1024 * 1024 // 125MB memory
        DataLoader.sharedUrlCache.diskCapacity = 1000 * 1024 * 1024 // 1000MB disk

        #if !os(tvOS)
        WidgetCenter.shared.reloadAllTimelines()
        UIScrollView.appearance().keyboardDismissMode = .onDrag
        #endif

        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(didLogIn), name: Notification.Name("didSignIn"), object: nil)
        nc.addObserver(self, selector: #selector(didLogOut), name: Notification.Name("didSignOut"), object: nil)
    }

    @objc func didLogIn() {
        LogManager.shared.log.info("Received `didSignIn` from NSNotificationCenter.")
        isLoggedIn = true
    }

    @objc func didLogOut() {
        LogManager.shared.log.info("Received `didSignOut` from NSNotificationCenter.")
        isLoggedIn = false
    }
}
