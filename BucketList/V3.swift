//
//  V#.swift
//  BucketList
//
//  Created by Rajabaliyev01 on 13/05/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct failedView: View {
    var body: some View {
        Text("Failed!")
    }
}

struct V3: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    @State private var loadingState: LoadingState = .loading
    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            failedView()
        }
    }
}

#Preview {
    V3()
}
