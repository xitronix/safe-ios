//
//  Copyright © 2019 Gnosis Ltd. All rights reserved.
//

import Foundation

public protocol TrackingHandler {
    func track(view: TrackingView, contentId: String?, parameters: [String: Any]?)
    func track(event: TrackingEvent, view: TrackingView?, parameters: [String: Any]?)
    func setScreenName(_ name: String, class: String?)
}

public class Tracker {

    public static let shared = Tracker()

    private var trackingHandlers = [TrackingHandler]()

    public func append(handler: TrackingHandler) {
        trackingHandlers.append(handler)
    }

    public func track(view: TrackingView, contentId: String? = nil, parameters: [String: Any]? = nil) {
        for handler in trackingHandlers {
            handler.track(view: view, contentId: contentId, parameters: parameters)
        }
    }

    public func track(event: TrackingEvent, view: TrackingView? = nil, parameters: [String: Any]? = nil) {
        for handler in trackingHandlers {
            handler.track(event: event, view: view, parameters: parameters)
        }
    }

    public func setScreenName(_ name: String, class: AnyClass? = nil) {
        for handler in trackingHandlers {
            let className = `class` != nil ? String(describing: `class`!) : nil
            handler.setScreenName(name, class: className)
        }
    }

}
