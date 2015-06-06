//
//  PlayRecordedAudioViewController.swift
//  sound effects
// application to record sound and play it with some effects
//
//  Created by Ahmed Atyya Ali on 6/2/15.
//  Copyright (c) 2015 Ahmed Atyya Ali. All rights reserved.
//

import UIKit
import AVFoundation
class PlayRecordedAudioViewController: UIViewController {
    //intailizing some variables
    var receivedAudio:RecordedAudio! //it is the received audio file from the RecordAudioViewController Class
    var AudioPlayer:AVAudioPlayer! //the audio player to play the Files
    var audioEngine: AVAudioEngine! //audio engine is used to make some effects on the audio
    var audiofile: AVAudioFile! //audio File to be played


    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("PlayRecordedAudioViewController: viewDidLoad")
//initialization of the AudioPlayer instance
        AudioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.pathURL, error: nil)
        //enable the rate to be changed and make the effect
        AudioPlayer.enableRate = true
        //initializing the audioEngine instance and audiofile
        audioEngine = AVAudioEngine()
        audiofile = AVAudioFile(forReading: receivedAudio.pathURL, error: nil)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        println("PlayRecordedAudioViewController: didReceiveMemoryWarning")
    }
    //action function for the slow rate sound play effect
    @IBAction func slowPlay(sender: UIButton) {
        
       
        playAudioWithVariableRate(0.5)
    }
    //action function for the fast rate sound play effect
    @IBAction func fastPlay(sender: UIButton) {
        playAudioWithVariableRate(2.5)
       
            }
    //function changing the audio rate dynamically
    func playAudioWithVariableRate(rate:Float){
       stopAllAudio()
        AudioPlayer.rate = rate
        AudioPlayer.play()

    }
    //function to stop all the sounds
    @IBAction func stopAllAudio(){
        AudioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    //action for the chipmunk effect button
    @IBAction func chipmunkPlay(sender: UIButton) {
        playAudioWithVariablePitch(1000)
     
    }
    //function to play the pitch effect automatically
    func playAudioWithVariablePitch(pitch:Float){
       stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audiofile, atTime: nil, completionHandler:nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
        //action for the darthvader effect button
    @IBAction func darthvaderPlay(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
}
