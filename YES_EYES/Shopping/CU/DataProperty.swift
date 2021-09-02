//
//  DataProperty.swift
//  YES_EYES
//
//  Created by Moon on 2021/09/02.
//

import Foundation

//
//struct UserDataCache {
//    static let key = "userDataCache"
//    static func save(_ value: Cart!) {
//         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
//    }
//    static func get() -> Cart! {
//        var cartData: Cart!
//        if let data = UserDefaults.standard.value(forKey: key) as? Data {
//            cartData = try? PropertyListDecoder().decode(Cart.self, from: data)
//            return cartData!
//        } else {
//            return cartData
//        }
//    }
//    static func remove() {
//        UserDefaults.standard.removeObject(forKey: key)
//    }
//}
