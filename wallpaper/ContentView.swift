//
//  ContentView.swift
//  wallpaper
//
//  Created by Bibek Chand on 15/03/2026.
//

import UniformTypeIdentifiers
import SwiftUI

struct ContentView: View {
    @State var showFileImporter = false
    var body: some View {
        VStack {
            Text("Import the video here 👇")
            Button("Import file") {
                print("Debug")
                showFileImporter = true
            }.fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.movie]) { result in
                switch result {
                case .success(let urls):
                    let canAccess = urls.startAccessingSecurityScopedResource()
                    if canAccess {
                        WallPaperViewController.shared.createWallPaper(url: urls)
                    }
                    else {
                        print("Failed in Accessing Video")
                    }
                case .failure:
                    print("Failed fetching video")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
