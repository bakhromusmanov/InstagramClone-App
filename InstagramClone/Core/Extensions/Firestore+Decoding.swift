//
//  Firestore+Decoding.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 23/05/25.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    func decode<T: Decodable>(as type: T.Type) -> T? {
        do {
            return try data(as: type)
        } catch {
            print("Error decoding document \(documentID): \(error.localizedDescription)")
            return nil
        }
    }
}
