//
//  WallPaperViewController.swift
//  wallpaper
//
//  Created by Bibek Chand on 15/03/2026.
//
import Cocoa
class WallPaperViewController {
    static let shared = WallPaperViewController()
    private init() {}
    func createWallPaper() {
        let window = NSWindow(contentRect: NSScreen.main!.frame, styleMask: [.borderless], backing: .buffered, defer: false)
        window.alphaValue = 1
        window.isOpaque = true
        window.ignoresMouseEvents = true
        window.collectionBehavior = [
            .canJoinAllSpaces, .stationary, .fullScreenAuxiliary, .ignoresCycle
        ]
        let contentView = NSView(frame: NSScreen.main!.frame)
        contentView.wantsLayer = true
        window.contentView = contentView
        window.orderFrontRegardless()
    }
}
