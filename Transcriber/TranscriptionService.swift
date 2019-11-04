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
        // if SFSpeechRecognizer.authorizationStatus() == SFSpeechRecognizerAuthorizationStatus.authorized {
        //    // All good!
        //    print("Bypassing permissions request, because we seem to be authorized already.")
        //    return
        // }

        // TODO: Sort out which of the following cases we get an authorization callback for:
        // SFSpeechRecognizerAuthorizationStatus.notDetermined
        // SFSpeechRecognizerAuthorizationStatus.denied
        // SFSpeechRecognizerAuthorizationStatus.restricted
        // SFSpeechRecognizerAuthorizationStatus.authorized

        print("Requesting speech recognizer permission")

        SFSpeechRecognizer.requestAuthorization { authStatus in
            // TODO: Write something into a queue and use an FSM to coordinate things...
            // DispatchQueue.main.async {
            if authStatus == .authorized {
                print("Transcribe permission obtained")
            } else {
                print("Transcribe permission denied")
            }
            // }
        }
    }

    func transcribeAudio(url: URL) {
        // create a new recognizer and point it at our audio
        let recognizer = SFSpeechRecognizer(locale: Locale.current)
        if recognizer == nil {
            print("Got nil recognizer.  Bailing.")
            return
        }

        // On a pure CLI app, the following always prints/returns.  On a "GUI" app, it never does,
        // even if I decline permissions:
        // if !recognizer!.isAvailable {
        //    print("Recognizer is unavailable.  Bailing.")
        //    return
        // }

        // DispatchQueue.main.async {
        print("Beginning transcription")

        let request = SFSpeechURLRecognitionRequest(url: url)

        recognizer?.recognitionTask(with: request) { result, error in
            // TODO: Write something into a queue and use an FSM to coordinate things...

            // Abort if we didn't get any transcription back
            guard let result = result else {
                print("FAIL: \(error!)")
                return
            }

            // Print whatever we've got, along with whether or not it's final
            if result.isFinal {
                print("FINAL RESULT: ", result.bestTranscription.formattedString)
            } else {
                print("INTERMEDIATE: ", result.bestTranscription.formattedString)
            }
        }

        return
            // }
    }
}
