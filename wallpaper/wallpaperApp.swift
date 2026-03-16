//
//  wallpaperApp.swift
//  wallpaper
//
//  Created by Bibek Chand on 15/03/2026.
//

import SwiftUI

@main
struct wallpaperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    //on appear matra garney because some weird bug happens if you do it in init
//                    WallPaperViewController.shared.createWallPaper()
                }
        }
    }
}
