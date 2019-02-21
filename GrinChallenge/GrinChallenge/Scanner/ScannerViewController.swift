//
//  ScannerViewController.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/17/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScannerViewControllerDelegate: class {
    func scannerViewControllerDidCapture(barcode: String)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    //Outlets
    @IBOutlet var topbar: UIView!
    
    weak var delegate: ScannerViewControllerDelegate?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.interleaved2of5,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        captureSession?.stopRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                self.setupCameraView()
            } else if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.denied {
                let alert = UIAlertController(
                    title: "Acceso a la Cámara Deshabilitado",
                    message: "Para Habilitar el Uso de la Cámara, Abra la Configuración de Ésta Aplicación y Establezca el Acceso a la Cámara.",
                    preferredStyle: UIAlertController.Style.alert
                )
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.notDetermined {
                AVCaptureDevice.requestAccess(for: AVMediaType.video)
                { granted in
                    DispatchQueue.main.async() {
                        if granted {
                            self.setupCameraView()
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupCameraView() {
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            //view.bringSubview(toFront: messageLabel)
//            view.bringSubviewToFront(topbar)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }

    }
    
    func sendInfoToTextField (barcode: String) {
        delegate?.scannerViewControllerDidCapture(barcode: barcode)
        let barcodeDict:[String: String] = ["barcode": barcode]
    }
 
    @IBAction func closeView(_ sender: UIButton) {
        captureSession?.stopRunning()
        self.dismiss(animated:true, completion:nil)
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
//            messageLabel.text = "No QR/barcode is detected"
            return
        }
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            if metadataObj.stringValue != nil {
                sendInfoToTextField(barcode: metadataObj.stringValue ?? "")
                captureSession?.stopRunning()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
