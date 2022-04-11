//
//  HapticManager.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 11/04/2022.
//

import Foundation
import UIKit

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type : UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
