//
//  UnixInterface.swift
//  Transcriber
//
//  Created by Jonathon Frisby on 11/5/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Foundation

class UnixInterface {
    // Constants for exit codes:
    // TODO: Use a proper enum?
    static let Success: Int32 = 0
    static let ErrInvalidArgs: Int32 = 1
    static let ErrRecognizerUnavailable: Int32 = 2
    static let ErrSpeechPermissionDenied: Int32 = 3
    static let ErrRecognitionFailed: Int32 = 4
}
