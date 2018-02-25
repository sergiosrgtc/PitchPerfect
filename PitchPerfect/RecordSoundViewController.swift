//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Sergio Costa on 22/02/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK:- Variables
    var audioRecorder: AVAudioRecorder!
    var recordingState = RecordingStateEnum.notRecording
    
    // MARK:- Enum
    enum RecordingStateEnum { case recording, notRecording }
    
    // MARK:- Alerts
    struct Alerts {
        static let AudioSessionAlert = "Error to start audio session"
        static let AudioRecorderDidFinishRecordingAlert = "Audio Recorder Did Finish Recording"
        static let AVAudioSessionSetCategoryAlert = "Error to set Audio Session"
        static let AVAudioRecorderAlert = "Error to set Audio Recorder"
    }
    
    //MARK:- Outlets
    @IBOutlet weak var recordingLabel : UILabel!
    @IBOutlet weak var recordButton : UIButton!

    // MARK:- ViewController func
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingLabel.text = "Tap to Record"
        // Transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = sender as! URL
        }
    }
    
    //MARK:- IBAction
    @IBAction func recordAudio(_ sender: AnyObject) {
        switch recordingState {
        case .notRecording:
            recordingLabel.text = "Recording in progress - Tap to stop"
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = URL(string: pathArray.joined(separator: "/"))
            
            let session = AVAudioSession.sharedInstance()
            do{
                try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            }catch{
                showAlert(Alerts.AVAudioSessionSetCategoryAlert, message: "Error: \(error).")
            }
            do{
                try audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            }catch{
                showAlert(Alerts.AVAudioRecorderAlert, message: "Error: \(error).")
            }
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            recordButton.setImage(#imageLiteral(resourceName: "Stop"), for: UIControlState.normal)
            recordingState = .recording
        case .recording:
            recordingLabel.text = "Tap to Record"
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            do{
                try audioSession.setActive(false)
            }catch{
                showAlert(Alerts.AudioSessionAlert, message: "Error: \(error).")
            }
            recordButton.setImage(#imageLiteral(resourceName: "Record"), for: UIControlState.normal)
            recordingState = .notRecording
        }
    }
    
    //MARK:- AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            showAlert(Alerts.AudioSessionAlert, message: "Error: could not finish recording.")
        }
    }
}

