//
//  ConsoleIO.swift
//  Transcriber
//
//  Created by Mat Ellis on 11/1/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Foundation

enum OutputType {
    case error
    case standard
}

class ConsoleIO {
    func getFilename() -> String {
        printUsage()
        let filename = CommandLine.arguments[1]

        writeMessage("Filename: \(filename)")
        return filename
    }

    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\(message)")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }

    func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent

        writeMessage("usage:")
        writeMessage("\(executableName) -f file")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
    }
}
