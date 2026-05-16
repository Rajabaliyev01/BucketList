//
//  V2.swift
//  BucketList
//
//  Created by YancharQuyon on 13/05/26.
//

import SwiftUI

struct V2: View {
   
    
    var body: some View {
        Button("text", systemImage: "message") {
            let data = Data("test".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url, encoding: .utf8)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    V2()
}
