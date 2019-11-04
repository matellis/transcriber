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
        if CommandLine.argc < 2 {
            print("TODO: Usage.")
            return
        }

        let transcriber = TranscriptionService()

        transcriber.requestTranscribePermissions()

        let rawFilenameArg = CommandLine.arguments[1]
        let computedFilename = Path(rawFilenameArg).absolute().string
        print("ACCESSING: ", computedFilename)

        let fileURL = URL(string: "file://" + computedFilename.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print("COMPUTED URL: ", fileURL!)

        transcriber.transcribeAudio(url: fileURL!)
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}
