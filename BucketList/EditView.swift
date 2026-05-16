//
//  EditView.swift
//  BucketList
//
//  Created by Rajabaliyev01 on 15/05/26.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }

    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void

    @State private var name: String
    @State private var description: String

    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()

    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 0.05, green: 0.11, blue: 0.16)
                    .ignoresSafeArea()
                Form {
                    Section {
                        TextField("Place name", text: $name)
                        TextField("Description", text: $description)
                    }
                    .listRowBackground(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white.opacity(0.07))
                                    )
                    
                    Section("Nearby…") {
                        switch loadingState {
                        case .loaded:
                            ForEach(pages, id: \.pageid) { page in
                                VStack(alignment: .leading, spacing: 3) {
                                                                Text(page.title)
                                                                    .font(.subheadline.weight(.medium))
                                                                    .foregroundStyle(.white)
                                                                Text(page.description)
                                                                    .font(.caption)
                                                                    .italic()
                                                                    .foregroundStyle(.white.opacity(0.45))
                                                            }
                                                            .padding(.vertical, 4)
                            }
                        case .loading:
                            Text("Loading…")
                        case .failed:
                            Text("Please try again later.")
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.07))
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Place details")
                .navigationBarTitleDisplayMode(.inline)
                            .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save") {
                            var newLocation = location
                            newLocation.id = UUID()
                            newLocation.name = name
                            newLocation.description = description
                            
                            onSave(newLocation)
                            dismiss()
                        }
                        .fontWeight(.medium)
                    }
                }
                .task {
                    await fetchNearbyPlaces()
                }
            }
            
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // we got some data back!
            let items = try JSONDecoder().decode(Result.self, from: data)

            // success – convert the array values to our pages array
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            // if we're still here it means the request failed somehow
            loadingState = .failed
        }
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
