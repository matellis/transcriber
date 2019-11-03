//
//  main.swift
//  Transcriber
//
//  Created by Mat Ellis on 11/1/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Foundation

let transcriber = Transcriber()
let consoleIO = ConsoleIO()

if CommandLine.argc < 2 {
    // TODO: Exit
} else {
    transcriber.requestTranscribePermissions()
    let filename = consoleIO.getFilename()
    let file = URL(string: filename.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    // let text = transcriber.transcribeAudio(url: file!)
    // print ("Text: \(text)")
    transcriber.transcribeAudio(url: file!)
}
