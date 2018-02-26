//
//  PlayViewController.swift
//  PitchPerfect
//
//  Created by Sergio Costa on 22/02/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK:- Constants
    let slowRate : Float = 0.4
    let fastRate : Float = 2.3
    let highPitchRate : Float = 1500
    let lowPitchRate : Float = -1050
    
    // MARK:- Variables
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK:- Enum
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK:- Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK:- ViewController func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
   
    // MARK:- IBAction
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: slowRate)
        case .fast:
            playSound(rate: fastRate)
        case .chipmunk:
            playSound(pitch: highPitchRate)
        case .vader:
            playSound(pitch: lowPitchRate)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        if audioPlayerNode.isPlaying{
            audioPlayerNode.pause()
            configureUI(.paused)
        }else{
            audioPlayerNode.play()
            configureUI(.playing)
        }
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        if audioPlayerNode != nil && audioPlayerNode.isPlaying{
            audioPlayerNode.stop()
        }
        navigationController?.popViewController(animated: true)
    }
}
