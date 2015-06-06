//
//  RecordAudioViewController.swift
//  sound effects
//
//  Created by Ahmed Atyya Ali on 6/2/15.
//  Copyright (c) 2015 Ahmed Atyya Ali. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopButton.hidden = true
    }

 

    @IBAction func RecordingAction(sender: UIButton) {
        recordingButton.enabled = false
        recordingLabel.text = "Record inprogress"
        recordingLabel.enabled = false
        stopButton.hidden = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
     
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
      
     
        
        if(flag){
            
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, pathURL: recorder.url)
       
            self.performSegueWithIdentifier("toRecordedAudio", sender: recordedAudio)
        
        }else{
     
            recordingButton.enabled = true
            recordingLabel.hidden = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toRecordedAudio"){
            
            let playRecordedVC :PlayRecordedAudioViewController = segue.destinationViewController as! PlayRecordedAudioViewController
            let data = sender as! RecordedAudio
            playRecordedVC.receivedAudio = data
            

        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {

        recordingButton.enabled = true
        recordingLabel.enabled = true
        recordingLabel.text = "Tab to record"
        stopButton.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

