//
//  V1.swift
//  BucketList
//
//  Created by Rajabaliyev01 on 11/05/26.
//

import SwiftUI

struct User: Comparable, Identifiable {
    let id = UUID()
    var firstName: String
    var secondName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName > rhs.firstName
    }
}

struct V1: View {
    let users = [
        User(firstName: "asd", secondName: "rqf"),
        User(firstName: "dwexz", secondName: "zxc"),
        User(firstName: "tghbb", secondName: "ert")
    ].sorted()

    
    var body: some View {
        List(users) { user in
            Text("\(user.secondName), \(user.firstName)")
        }
    }
}

#Preview {
    V1()
}
