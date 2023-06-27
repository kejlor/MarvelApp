//
//  QrCodeCameraDelegate.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import Foundation
import AVFoundation

class QrCodeCameraDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    var scanInterval: Double = 1.0
    var lastTime = Date(timeIntervalSince1970: 0)
    
    var onResult: (String) async -> Void = { _  in }
    var mockData: String?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) async {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            await foundBarcode(stringValue)
        }
    }
    
    @objc func onSimulateScanning() async{
        await foundBarcode(mockData ?? "323")
    }
    
    func foundBarcode(_ stringValue: String) async {
        let now = Date()
        if now.timeIntervalSince(lastTime) >= scanInterval {
            lastTime = now
            try? await self.onResult(stringValue)
        }
    }
}
