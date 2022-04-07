//
//  UIApplication.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 07/04/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
