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
            playSound(rate: 0.4)
        case .fast:
            playSound(rate: 2.3)
        case .chipmunk:
            playSound(pitch: 1500)
        case .vader:
            playSound(pitch: -1100)
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
        self.navigationController?.popViewController(animated: true)
    }
}
