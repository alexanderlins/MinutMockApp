//
//  Cube.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import SwiftUI
import SceneKit

struct Controller: View {
    var body: some View {
        Controller3D()
    }
}

#Preview {
    Controller()
}

struct Controller3D: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        
        // MARK: Scene
        let scene = SCNScene(named: "Controller.scn")
        
        // MARK: Camera
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.name = "camera"
        //DECIDING ITS FIELD OF VIEW
        cameraNode.camera?.fieldOfView = 60
        
        //DECIDING ITS POSITION
        cameraNode.position = SCNVector3(x: 0.0175, y: 0.0, z: 3)
        
        //CONFIGURING THAT WE CAN COME CLOSER ENOUGH SO WE WON'T OVERLAP THE OBJECT.
        cameraNode.camera?.zNear = 0.01
        cameraNode.camera?.wantsDepthOfField = true
        cameraNode.camera?.colorFringeIntensity = 100
        cameraNode.camera?.colorFringeStrength = 50
        cameraNode.camera?.focusDistance = 3
        cameraNode.camera?.fStop = 2
        
        // MARK: View
        let view = SCNView(frame: .zero)
        view.scene = scene
        view.scene?.rootNode.addChildNode(cameraNode)
        
        
        // MARK: Camera Configuration
        view.allowsCameraControl = true
        view.backgroundColor = .clear
        view.cameraControlConfiguration.allowsTranslation = false
        
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if let pinchRecognizer = recognizer as? UIPinchGestureRecognizer {
                    // Disable the pinch recognizer
                    pinchRecognizer.isEnabled = false
                }
            }
        }
        
        // MARK: Scene Light
        view.autoenablesDefaultLighting = true
        
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
        //Animating the Controller
        let rotation = SCNAction.rotateBy(x: 0.2, y: CGFloat.pi * 0.2, z: 0, duration: 1)
        let repeatRotation = SCNAction.repeatForever(rotation)
        
        uiView.scene?.rootNode.childNode(withName: "Geom", recursively: true)?.runAction(repeatRotation)
    }
}
