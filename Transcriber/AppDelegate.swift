//
//  AppDelegate.swift
//  Transcriber
//
//  Created by Jonathon Frisby on 11/3/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(transcriptionHandler: {
            self.doTheThing()
        })

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func doTheThing() {
        let transcriber = TranscriptionService()
        let consoleIO = ConsoleIO()

        if CommandLine.argc < 2 {
            // TODO: Exit
        } else {
            let waiter = DispatchGroup()
            transcriber.requestTranscribePermissions(waiter: waiter)
            waiter.wait() // Blocks until the callback in requestTranscribePermissions is executed.

            let filename = consoleIO.getFilename()
            let file = URL(string: filename.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            // let text = transcriber.transcribeAudio(url: file!)
            // print ("Text: \(text)")
            transcriber.transcribeAudio(url: file!, waiter: waiter)
            waiter.wait()
        }
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}
