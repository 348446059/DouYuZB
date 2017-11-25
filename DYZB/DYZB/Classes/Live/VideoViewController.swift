//
//  VideoViewController.swift
//  DYZB
//
//  Created by libo on 2017/11/24.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import AVFoundation
class VideoViewController: UIViewController {
  
    fileprivate lazy var videoQueue = DispatchQueue.global()
    
    fileprivate lazy var audioQueue = DispatchQueue.global()
    
    fileprivate  var session  = AVCaptureSession()
    
    fileprivate  var videoOutput  :AVCaptureVideoDataOutput?
    
    fileprivate lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    fileprivate var videoInput:AVCaptureDeviceInput?
    
    fileprivate var movieOutput:AVCaptureMovieFileOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    
    
   
    
}




extension VideoViewController{
    
    @IBAction func startAction(_ sender: Any) {
        //1.设置视频的输入输出
        setupVideo()
        
        //2.设置音频的输入
        setupAudio()
        
        //3.添加写入文件的output
        let movieOutput = AVCaptureMovieFileOutput()
        session.addOutput(movieOutput)
        self.movieOutput = movieOutput
        //设置写入的稳定性
        let connection = movieOutput.connection(with: .video)
        connection?.preferredVideoStabilizationMode = .auto
        
        //3.给用户看到预览图层
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        
        //4.开始采集
        session.startRunning()
        
        
        //将采集到的画面写入
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/sam.mp4"
        
            
        let url = URL(fileURLWithPath: path)
        
        movieOutput.startRecording(to: url, recordingDelegate: self)
    }
    
    @IBAction func endAction(_ sender: Any) {
        movieOutput?.stopRecording()
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
    
    @IBAction func switchAction(_ sender: Any) {
        //1.获取之前的镜头
        guard var position = videoInput?.device.position else{return}
        
        //2.获取当前该显示的镜头
        position  = position == .front ? .back : .front
        
       //3.根据当前镜头创建新的InPut
        let devices = AVCaptureDevice.devices(for: .video)
        let device =  devices.filter {
            return $0.position == position
        }.first
       
        guard let videoInput = try? AVCaptureDeviceInput(device: device!) else {
            return
        }
        session.beginConfiguration()
        session.removeInput(self.videoInput!)
        session.addInput(videoInput)
        session.commitConfiguration()
        self.videoInput = videoInput
        
        
    }
    fileprivate func setupAudio(){
        guard  let device = AVCaptureDevice.default(for: .audio) else{ return }
        
        //创建audio输入
        guard  let audioInput = try? AVCaptureDeviceInput(device: device) else{return}
        
        session.addInput(audioInput)
        
        //设置会话音频输出源
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)
    }
    private func setupVideo(){
        
        //2.给捕捉会话设置输入原(摄像头)
        let devices = AVCaptureDevice.devices(for: .video)
        
        let device = devices.filter { (device) -> Bool in
            return device.position == .front
            }.first
        
        let videoInput = try? AVCaptureDeviceInput(device: device!)
        
        self.videoInput = videoInput
        session.addInput(videoInput!)
        //3.给捕捉会话设置输出源
        let videoOut = AVCaptureVideoDataOutput()
        videoOut.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOut)
        self.videoOutput = videoOut
        
       
    }
}


extension VideoViewController:AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if connection == self.videoOutput?.connection(with: .video) {
             print("已经采集到画面")
        }else{
            print("已经采集到音频数据")
        }
       
    }
    
    
}


extension VideoViewController:AVCaptureFileOutputRecordingDelegate{
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("开始写入")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("结束写入")
    }
    
    
    
    
    
}





























