//
//  WallPaperViewController.swift
//  wallpaper
//
//  Created by Bibek Chand on 15/03/2026.
//
import AVKit
import AVFoundation
import Cocoa
class WallPaperViewController {
    static let shared = WallPaperViewController()
    private var looper: AVPlayerLooper?
    private var currentWindow: NSWindow?
    private var player: AVQueuePlayer?
    private init() {}
    private func animateReveal(fromCenter center: CGPoint, in view: NSView) {
        let startPath = NSBezierPath(ovalIn: CGRect(origin: center, size: .zero))
        let maxDimension = max(view.bounds.width, view.bounds.height) * 1.5
        let endPath = NSBezierPath(ovalIn: CGRect(
            x: center.x - maxDimension,
            y: center.y - maxDimension,
            width: maxDimension * 2,
            height: maxDimension * 2
        ))

        let maskLayer = CAShapeLayer()
        maskLayer.path = endPath.cgPath
        view.layer?.mask = maskLayer

        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = 0.6
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        maskLayer.add(animation, forKey: "reveal")
        maskLayer.path = endPath.cgPath

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            view.layer?.mask = nil
        }
    }
    func createWallPaper(url: URL) {
        //close the previous window
        if let oldWindow = self.currentWindow {
            oldWindow.close()
            self.currentWindow = nil
        }
        //create a window object from ns window
        self.currentWindow = NSWindow(contentRect: NSScreen.main!.frame, styleMask: [.borderless], backing: .buffered, defer: false)
        //have the transparency to 1 show it is showing
        self.currentWindow?.setFrame(NSScreen.main!.frame, display: true)
        self.currentWindow?.level = NSWindow.Level(Int(CGWindowLevelForKey(.desktopWindow)) - 1)
        self.currentWindow?.alphaValue = 1
        self.currentWindow?.isOpaque = true
        self.currentWindow?.ignoresMouseEvents = true
        self.currentWindow?.collectionBehavior = [
            .canJoinAllSpaces, .stationary, .fullScreenAuxiliary, .ignoresCycle
        ]
        let contentView = NSView(frame: NSScreen.main!.frame)
        //layer to draw upon the window
        contentView.wantsLayer = true
        self.currentWindow?.contentView = contentView
        let item = AVPlayerItem(url: url)
        item.preferredForwardBufferDuration = 0
        self.player = AVQueuePlayer()
        player?.isMuted = true
        player?.automaticallyWaitsToMinimizeStalling = false
        self.looper = AVPlayerLooper(player: player!, templateItem: item)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = NSScreen.main!.frame
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.needsDisplayOnBoundsChange = true
        contentView.layer = playerLayer
        self.currentWindow?.orderFrontRegardless()
        contentView.layoutSubtreeIfNeeded()
        animateReveal(fromCenter: CGPoint(x: NSScreen.main!.frame.width / 2, y: NSScreen.main!.frame.height / 2), in: contentView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.player?.play()
        })
    }
}
