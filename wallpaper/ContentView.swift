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
                case .success(let url):
                    guard url.startAccessingSecurityScopedResource() else { return }
                    defer {
                        url.stopAccessingSecurityScopedResource()
                    }
                        UserDefaultsManager.shared.saveURL(url:url)
                        WallPaperViewController.shared.createWallPaper(url: url)
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
