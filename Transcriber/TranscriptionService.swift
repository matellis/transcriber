//
//  Transcriber.swift
//  Transcriber
//
//  Created by Mat Ellis on 11/1/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Speech

class TranscriptionService {
    func requestTranscribePermissions() {
        if SFSpeechRecognizer.authorizationStatus() == SFSpeechRecognizerAuthorizationStatus.authorized {
            // All good!
            print("Bypassing permissions request, because we seem to be authorized already.")
            return
        }

        // TODO: Sort out which of the following cases we get an authorization callback for:
        // SFSpeechRecognizerAuthorizationStatus.notDetermined
        // SFSpeechRecognizerAuthorizationStatus.denied
        // SFSpeechRecognizerAuthorizationStatus.restricted
        // SFSpeechRecognizerAuthorizationStatus.authorized

        print("Requesting speech recognizer permission")

        let waiter = DispatchGroup()
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
        waiter.wait()
    }

    func transcribeAudio(url: URL) {
        // create a new recognizer and point it at our audio
        let recognizer = SFSpeechRecognizer(locale: Locale.current)
        if recognizer == nil {
            print("Got nil recognizer.  Bailing.")
            return
        }
        // if !recognizer!.isAvailable {
        //    print("Recognizer is unavailable.  Bailing.")
        //    return
        // }

        let request = SFSpeechURLRecognitionRequest(url: url)
        print("Beginning transcription")

        let waiter = DispatchGroup()
        waiter.enter()
        recognizer?.recognitionTask(with: request) { result, error in
            print("Got a callback!")

            // abort if we didn't get any transcription back
            guard let result = result else {
                print("BAD")
                print("There was an error in transcribing: \(error!)")
                waiter.leave()
                return
            }

            // if we got the final transcription back, print it
            if result.isFinal {
                // pull out the best transcription...
                print("FINAL RESULT: ", result.bestTranscription.formattedString)
                waiter.leave()
            } else {
                print("INTERMEDIATE: ", result.bestTranscription.formattedString)
            }
        }
        waiter.wait()
        print("Finished transcription")

        return
    }
}
