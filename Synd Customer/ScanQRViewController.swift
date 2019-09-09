import UIKit
import AVFoundation
import FirebaseAuth

struct User: Encodable {
    let email: String?
}

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    @IBOutlet weak var scanlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setupCaptureSession()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
            
        case .denied: // The user has previously denied access.
            return
        case .restricted: // The user can't grant access due to restrictions.
            return
        default:
            return
        }
        
        view.bringSubviewToFront(scanlabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = true
//        captureSession.startRunning()
    }
    
    func setupCaptureSession()
    {
        captureSession.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(for: .video)
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        let metadataOutput = AVCaptureMetadataOutput()
        guard captureSession.canAddOutput(metadataOutput) else { return }
        captureSession.addOutput(metadataOutput)
        
        captureSession.commitConfiguration()
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = self.view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            return
        }
        guard metadataObject.stringValue == "395621" else {
            return
        }
        self.scanlabel.text = "Syndicate bank ****** QR code detected. \nYou are being checked in automatically"
        captureSession.stopRunning()
        addUserToQueue()
    }
    
    func addUserToQueue() {
        let urlString = "https://hack321.herokuapp.com/add"
        let url = URL(string: urlString)
        var request = URLRequest.init(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let email = Auth.auth().currentUser?.email
        let user = User.init(email: email)
        guard let uploadData = try? JSONEncoder().encode(user) else { return }
        URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            //api success
            DispatchQueue.main.async {
                if (email?.hasPrefix("syd"))! {
                    hniLabelText = "HNI CUSTOMER PRESENT!\n"
                    hniLabelText += (Auth.auth().currentUser?.displayName)! + "\n"
                    hniLabelText += (Auth.auth().currentUser?.phoneNumber)! + "\n"
                    hniLabelText += (Auth.auth().currentUser?.email)!
                    self.performSegue(withIdentifier: "toHNI", sender: self)
                }
                else {
                    self.performSegue(withIdentifier: "toQueue", sender: self)
                }
            }
            return
        }.resume()
    }
}
