//
//  V5.swift
//  BucketList
//
//  Created by Rajabaliyev01 on 14/05/26.
//
import LocalAuthentication
import SwiftUI

struct V5: View {
    @State private var isLocked = false
    var body: some View {
        VStack{
            if isLocked {
                Text("Welcome Back!")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticte)
    }
    func authenticte() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isLocked = true
                } else {
                    //
                }
            }
            
            
        } else {
            //
        }
    }
}

    


#Preview {
    V5()
}
