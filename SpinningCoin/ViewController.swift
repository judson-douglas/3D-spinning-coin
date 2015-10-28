//
//  ViewController.swift
//  SpinningCoin
//
//  Created by Judson Douglas on 10/27/15.
//  Copyright © 2015 Judson Douglas. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    
    let rotate90AboutZ = SCNAction.rotateByX(0.0, y: 0.0, z: CGFloat(M_PI_2), duration: 0.0)
    
    var currentAngle: Float = 0.0
    var coinNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.userInteractionEnabled = true
        sceneView.backgroundColor = UIColor.blackColor()
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        coinSceneSetup()
    }
    
    func coinSceneSetup() {
        
        let coinScene = SCNScene()
        //coin is rendered as a cylinder with a very small height
        let coinGeometry = SCNCylinder(radius: 50, height: 2)
        coinNode = SCNNode(geometry: coinGeometry)
        coinNode.position = SCNVector3Make(0.0, 25.0, 25.0)
        coinScene.rootNode.addChildNode(coinNode)
        //rotate coin 90 degrees about the z axis so that it stands upright
        coinNode.runAction(rotate90AboutZ)
       
        let shinyCoinMaterial = SCNMaterial()
        shinyCoinMaterial.diffuse.contents = UIColor.lightGrayColor()
        shinyCoinMaterial.specular.contents = UIColor.whiteColor()
        shinyCoinMaterial.shininess = 1.0
        coinGeometry.firstMaterial = shinyCoinMaterial
        sceneView.scene = coinScene
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        sceneView.addGestureRecognizer(panRecognizer)
    }
    
    //allows for coin to spin with a right or left finger swipe, while still keeping it rotated 90 degrees about z axis
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        newAngle += currentAngle
        coinNode.runAction(SCNAction.rotateToX(CGFloat(newAngle), y: 0.0, z: CGFloat(M_PI_2), duration: 0.0))
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = newAngle
        }
    }
                             
    
   
    
}

