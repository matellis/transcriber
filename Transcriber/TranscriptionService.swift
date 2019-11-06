//
//  Transcriber.swift
//  Transcriber
//
//  Created by Mat Ellis on 11/1/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import Speech

class TranscriptionService {
    private let concurrentPhotoQueue = DispatchQueue(
        label: "com.tecnh.Transcriber.transcriptionQueue",
        attributes: .concurrent
    )

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

        // print("Requesting speech recognizer permission")

        SFSpeechRecognizer.requestAuthorization { authStatus in
            // TODO: Write something into a queue and use an FSM to coordinate things...
            if authStatus == .authorized {
                print("Transcribe permission obtained")
            } else {
                print("Transcribe permission denied")
                DispatchQueue.main.async {
                    exit(UnixInterface.ErrSpeechPermissionDenied)
                }
            }
        }
    }

    func transcribeAudio(url: URL) {
        let recognizer = SFSpeechRecognizer(locale: Locale.current)
        if recognizer == nil {
            print("ERROR: Couldn't obtain recognizer!")
            exit(UnixInterface.ErrRecognizerUnavailable)
        }

        // On a pure CLI app, the following always prints/returns.  On a "GUI" app, it never does,
        // even if I decline permissions:
        // if !recognizer!.isAvailable {
        //    print("Recognizer is unavailable.  Bailing.")
        //    return
        // }

        concurrentPhotoQueue.async() {
            print("Beginning transcription")

            let request = SFSpeechURLRecognitionRequest(url: url)

            // request.requiresOnDeviceRecognition = true
            // request.shouldReportPartialResults = true

            recognizer?.recognitionTask(with: request) { result, error in
                guard let result = result else {
                    print("ERROR: \(error!)")
                    DispatchQueue.main.async {
                        exit(UnixInterface.ErrRecognitionFailed)
                    }
                    return
                }

                // Print whatever we've got, along with whether or not it's final
                if result.isFinal {
                    // TODO: Write something into a queue and use an FSM to coordinate things...
                    print("FINAL RESULT: ", result.bestTranscription.formattedString)
                    DispatchQueue.main.async {
                        exit(UnixInterface.Success)
                    }
                } else {
                    print("INTERMEDIATE: ", result.bestTranscription.formattedString)
                }
            }

            return
        }
    }
}
