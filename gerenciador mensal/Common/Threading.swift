//
//  Threading.swift
//  gerenciador mensal
//
//  Created by Ana Carolina Ferreira on 30/04/22.
//

import Foundation

/// Ensures the closure is executed on main thread.
/// - Parameter closure: The closure to be executed on main thread.
internal func ensureMainThread(closure: @escaping () -> Void) {
    if Thread.current.isMainThread {
        closure()
    }
    else {
        DispatchQueue.main.async(execute: closure)
    }
}
