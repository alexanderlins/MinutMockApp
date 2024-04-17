//
//  Card.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import SwiftUI
import SceneKit

struct Card: View {
    var body: some View {
        Card3D()
    }
}

#Preview {
    Card()
}

struct Card3D: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let scene = SCNScene(named: "card.scn")
        let view = SCNView(frame: .zero)
        view.scene = scene
        
        
        // Camera Configuration
        view.allowsCameraControl = true
        view.backgroundColor = .clear
        view.cameraControlConfiguration.allowsTranslation = false
        view.defaultCameraController.maximumVerticalAngle = 30
        view.defaultCameraController.minimumVerticalAngle = -30
        view.defaultCameraController.maximumHorizontalAngle = 60
        view.defaultCameraController.minimumHorizontalAngle = -60
        
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if let pinchRecognizer = recognizer as? UIPinchGestureRecognizer {
                    // Disable the pinch recognizer
                    pinchRecognizer.isEnabled = false

                    // Alternatively, remove the pinch recognizer
                    // sceneView.removeGestureRecognizer(pinchRecognizer)
                }
            }
        }
        
        // Scene Light
        view.autoenablesDefaultLighting = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Nothing for now
    }
}
