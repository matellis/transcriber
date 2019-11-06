//
//  AppDelegate.swift
//  Transcriber
//
//  Created by Jonathon Frisby on 11/3/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Cocoa
// import PathKit
import Speech

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_: Notification) {
        if CommandLine.argc < 2 {
            print("TODO: Usage.")
            exit(UnixInterface.ErrInvalidArgs)
            // return
        }

        let computedFilename = CommandLine.arguments[1]
        // let computedFilename = Path(CommandLine.arguments[1]).absolute().string
        // print("ACCESSING: ", computedFilename)
        let fileURL = URL(fileURLWithPath: computedFilename)
        // let fileURL = URL(string: "file://" + computedFilename.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        // print("COMPUTED URL: ", fileURL.absoluteString)

        // TODO: Ensure the file exists, etc.

        let transcriber = TranscriptionService()

        transcriber.requestTranscribePermissions()

        transcriber.transcribeAudio(url: fileURL)
    }

    func applicationWillTerminate(_: Notification) {
        // TODO: We're using `exit` to end the program right now.  That doesn't go through the normal
        // TODO: Cocoa shutdown process.  Perhaps we want to change that?
    }
}
