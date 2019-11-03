//
//  Transcriber.swift
//  Transcriber
//
//  Created by Mat Ellis on 11/1/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Darwin
import Foundation
import Speech

class Transcriber {
    let consoleIO = ConsoleIO()

    func requestTranscribePermissions(waiter: DispatchGroup) {
        print("Requesting speech recognizer permission")
        waiter.enter()
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("Transcribe permission obtained")
                } else {
                    print("Transcribe permission denied")
                }
                waiter.leave()
            }
        }
    }

    func transcribeAudio(url: URL, waiter: DispatchGroup) {
        // create a new recognizer and point it at our audio
        let recognizer = SFSpeechRecognizer()
        if recognizer == nil {
            print("Got nil recognizer.  Bailing.")
            return
        }
        if !recognizer!.isAvailable {
            print("Recognizer is unavailable.  Bailing.")
            return
        }

        let request = SFSpeechURLRecognitionRequest(url: url)
        print("Beginning transcription")

        // start recognition!
        waiter.enter()
        recognizer?.recognitionTask(with: request) { result, _ in
            // abort if we didn't get any transcription back
            guard let result = result else { return } // else {
            //               print ("BAD")
            //               print ("There was an error in transcribing: \(error!)")
            //               return
            //           }

            // if we got the final transcription back, print it
            if result.isFinal {
                // pull out the best transcription...
                print("FINAL RESULT: ", result.bestTranscription.formattedString)
                waiter.leave()
            } else {
                print("INTERMEDIATE: ", result.bestTranscription.formattedString)
            }
        }
        print("Ending transcription")

        return
    }
}
