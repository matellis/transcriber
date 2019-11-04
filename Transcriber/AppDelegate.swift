//
//  AppDelegate.swift
//  Transcriber
//
//  Created by Jonathon Frisby on 11/3/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Cocoa
// import SwiftUI
import PathKit
import Speech

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_: Notification) {
        // Create the SwiftUI view that provides the window contents.
        // let contentView = ContentView(transcriptionHandler: {
        //    self.doTheThing()
        // })
        //
        //// Create the window and set the content view.
        // window = NSWindow(
        //    contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
        //    styleMask: [.titled, .closable, .miniaturizable],
        //    backing: .buffered, defer: false
        // )
        // window.center()
        // window.setFrameAutosaveName("Main Window")
        // window.contentView = NSHostingView(rootView: contentView)
        // window.makeKeyAndOrderFront(nil)
        doTheThing()
    }

    func doTheThing() {
        let transcriber = TranscriptionService()

        if CommandLine.argc < 2 {
            print("TODO: Usage.")
        } else {
            transcriber.requestTranscribePermissions()

            let rawFilenameArg = CommandLine.arguments[1]
            let computedFilename = Path(rawFilenameArg).absolute().string
            print("ACCESSING: ", computedFilename)

            let fileURL = URL(string: "file://" + computedFilename.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            print("COMPUTED URL: ", fileURL!)

            transcriber.transcribeAudio(url: fileURL!)
        }
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}
