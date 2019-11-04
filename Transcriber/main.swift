//
//  main.swift
//  Transcriber
//
//  Created by Mat Ellis on 11/1/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Foundation
import PathKit

let transcriber = TranscriptionService()
let consoleIO = ConsoleIO()

if CommandLine.argc < 2 {
    // TODO: Exit
} else {
    transcriber.requestTranscribePermissions()

    let rawFilenameArg = CommandLine.arguments[1]
    let computedFilename = Path(rawFilenameArg).absolute().string
    print("ACCESSING: ", computedFilename)

    let fileURL = URL(string: "file://" + computedFilename.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    print("COMPUTED URL: ", fileURL!)

    transcriber.transcribeAudio(url: fileURL!)
}
