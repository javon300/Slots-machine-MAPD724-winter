//
//  GameScene.swift
//  Slots
//
//  Created by javon maxwell on 2022-01-18.
//

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit


class GameScene: SKScene
{
    //variables from gamescene.sks
    //reels to be spon
    private var reel1 : Reel?
    private var reel2 : Reel?
    private var reel3 : Reel?
    
    private var plusBtn: Button?
    private var minusBtn: Button?
    private var spinBtn: Button?
    private var resetBtn: Button?
    private var quitBtn: Button?
    
    private var balanceLabel : SKLabelNode?
    private var balanceAmount : SKLabelNode?
    private var betLabel : SKLabelNode?
    private var betAmount : SKLabelNode?
    private var jackpotLabel : SKLabelNode?
    private var jackpotAmount : SKLabelNode?
    
    
    //local
    let slotOptions = ["slots_symbol_cherry", "slots_symbol_bell","slots_symbol_orange", "slots_symbol_7", "slot_symbol_grape", "star_good", "star_bad"]
    var currentWheelValue1:String = "star_bad"
    var currentWheelValue2:String = "star_bad"
    var currentWheelValue3:String = "star_bad"
    
    var wheelActive:Bool = false
  
    
    //did move to view
    override func didMove(to view: SKView)
    {
        name = "game"
        
        //add reels to screen
        reel1 = Reel()  //alloate memory  for variable
        reel1?.position = CGPoint(x: -204.378, y: 1.003)
        reel1?.size.width = CGFloat(161.648)
        reel1?.size.height = 510.224
        addChild(reel1!)
        spinWheel(whichWheel: 1) //spins wheel on created object (testing)
        
        reel2 = Reel()  //alloate memory  for variable
        reel2?.position = CGPoint(x: -2.63, y: 1.003)
        reel2?.size.width = 153.115
        reel2?.size.height = 510.224
        addChild(reel2!)
        spinWheel(whichWheel: 2)//spins wheel on created object (testing)
        
        reel3 = Reel()  //alloate memory  for variable
        reel3?.position = CGPoint(x: 191.879, y: 1.003)
        reel3?.size.width = 161.109
        reel3?.size.height = 510.224
        addChild(reel3!)
        spinWheel(whichWheel: 3)//spins wheel on created object)(testing)
        
        //add buttons to view
        spinBtn = Button(imageSting: "spin")
        spinBtn?.zPosition = 2      //about background
        spinBtn?.position = CGPoint(x: -4.903, y: -530)
        spinBtn?.size.width = 411.302
        spinBtn?.size.height = 100
        addChild(spinBtn!)
        
        minusBtn = Button(imageSting: "-bet")
        minusBtn?.zPosition = 1      //about background
        minusBtn?.position = CGPoint(x: -236.396, y: 357.939)
        minusBtn?.size.width = 173.208
        minusBtn?.size.height = 75.877
        addChild(minusBtn!)
        
        plusBtn = Button(imageSting: "+bet")
        plusBtn?.zPosition = 1      //about background
        plusBtn?.position = CGPoint(x: 228.482, y: 357.939)
        plusBtn?.size.width = 173.208
        plusBtn?.size.height = 75.877
        addChild(plusBtn!)
        
        quitBtn = Button(imageSting: "quit")
        quitBtn?.zPosition = 1      //about background
        quitBtn?.position = CGPoint(x: 222.23, y: -387.352)
        quitBtn?.size.width = 160.705
        quitBtn?.size.height = 76.21
        addChild(quitBtn!)
        
        resetBtn = Button(imageSting: "reset")
        resetBtn?.zPosition = 1      //above background
        resetBtn?.position = CGPoint(x: -242.648, y: -387.352)
        resetBtn?.size.width = 160.705
        resetBtn?.size.height = 76.21
        resetBtn?.color = UIColor.clear
        addChild(resetBtn!)
        
        
        // Get label node from scene.sks
        // because using variables that are already on display no need to use addchild
        self.balanceLabel = self.childNode(withName: "//balance_label") as? SKLabelNode
        balanceLabel?.color = UIColor.blue
        balanceLabel?.fontSize = 35.0
        balanceLabel?.fontColor = UIColor.systemYellow
        //balanceLabel?.fontName = "black"
        balanceLabel?.zPosition = 1      //above background
     
        
        self.balanceAmount = self.childNode(withName: "//balance_amount") as? SKLabelNode
        balanceAmount?.color = UIColor.blue
        balanceAmount?.fontSize = 35.0
        balanceAmount?.fontColor = UIColor.systemYellow
        //balanceAmount?.fontName = "black"
        balanceAmount?.zPosition = 1      //above background
        
        self.betLabel = self.childNode(withName: "//bet_label") as? SKLabelNode
        betLabel?.color = UIColor.blue
        betLabel?.fontSize = 35.0
        betLabel?.fontColor = UIColor.systemYellow
        //betLabel?.fontName = "black"
        betLabel?.zPosition = 1      //above background
        
        self.betAmount = self.childNode(withName: "//bet_amount") as? SKLabelNode
        betAmount?.color = UIColor.blue
        betAmount?.fontSize = 35.0
        betAmount?.fontColor = UIColor.systemYellow
        //betAmount?.fontName = "black"
        betAmount?.zPosition = 1      //above background
        
        self.jackpotLabel = self.childNode(withName: "//jackpot_label") as? SKLabelNode
        jackpotLabel?.color = UIColor.blue
        jackpotLabel?.fontSize = 40.0
        jackpotLabel?.fontColor = UIColor.systemYellow
        //jackpotLabel?.fontName = "black"
        jackpotLabel?.zPosition = 1      //above background
        
        self.jackpotAmount = self.childNode(withName: "//jackpot_amount") as? SKLabelNode
        jackpotAmount?.color = UIColor.blue
        jackpotAmount?.fontSize = 45.0
        jackpotAmount?.fontColor = UIColor.systemYellow
        //jackpotAmount?.fontName = "black"
        jackpotAmount?.zPosition = 1      //above background
    }
    
    func spin(reel: Reel, reelNum: Int)
    {
        var reelString: String
        if (reelNum == 1)
        {
            reelString = currentWheelValue1
        } else if (reelNum == 2)
        {
             reelString = currentWheelValue2
        } else if (reelNum == 3)
        {
             reelString = currentWheelValue1
        }else{return}
        // Get label node from scene and store it for use later
        // self.reel1 = self.childNode(withName: "//reell") as? Reel
        reel.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1.0),
                                    SKAction.setTexture(SKTexture(imageNamed: "slot_symbol_grape")),
                                   // SKAction.fadeOut(withDuration: 1.0),
                                    SKAction.setTexture(SKTexture(imageNamed: "slots_symbol_7")),
                                   // SKAction.fadeOut(withDuration: 1.0),
                                    SKAction.setTexture(SKTexture(imageNamed: "slots_symbol_bell")),
                                    ///SKAction.fadeOut(withDuration: 1.0),
                                    SKAction.setTexture(SKTexture(imageNamed: "slots_symbol_orange")),
                                    //SKAction.fadeOut(withDuration: 1.0),
                                    SKAction.setTexture(SKTexture(imageNamed: "slots_symbol_cherry")),
                                    //SKAction.fadeOut(withDuration: 1.0),
                                    SKAction.setTexture(SKTexture(imageNamed: "star_bad")),
                                    //SKAction.fadeOut(withDuration: 1.0),
                                    SKAction.setTexture(SKTexture(imageNamed: "star_good")),
                                    SKAction.setTexture(SKTexture(imageNamed: reelString))
                                    //final symbol is generated adter this function call in wheelSpin
                                    ])))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
//        if (wheelActive == false)
//        {
//            print ("spinning ...")
//            wheelActive = true
//
//            let wait:SKAction = SKAction.wait(forDuration: 1)
//            let spinWheel1:SKAction = SKAction.run{
//                self.spinWheel(whichWheel: 1)
//
//            }
//            let spinWheel2:SKAction = SKAction.run{
//                self.spinWheel(whichWheel: 2)
//            }
//            let spinWheel3:SKAction = SKAction.run{
//                self.spinWheel(whichWheel: 3)
//            }
//            let testWheelValues:SKAction = SKAction.run{
//                self.testValues()
//            }
//            self.run( SKAction.sequence( [wait, spinWheel1, wait, spinWheel2, wait, spinWheel3, wait, testWheelValues]))
//        }
    }
    
    //spin wheel function
    func spinWheel (whichWheel:Int)
    {
        //generates random based on slotOptions array length
        let randomNum:UInt32 = arc4random_uniform (UInt32 (slotOptions.count))
        
        //saves random value
        let wheelPick:String = slotOptions[Int(randomNum)]
        print (" wheel \(whichWheel) spun a value of \(wheelPick) ")
        
        if (whichWheel == 1)
        {
            //after random has run, spins reel and displays final image in reel
            currentWheelValue1 = wheelPick
            spin(reel: reel1!, reelNum: 1)
            //reel1?.texture: SKTexture(imageNamed: currentWheelValue1)
        } else if (whichWheel == 2)
        {
            //after random has run, spins reel and displays final image in reel
            currentWheelValue2 = wheelPick
            spin(reel: reel2!, reelNum: 2)
            reel2?.texture = SKTexture(imageNamed: currentWheelValue2)
        } else if (whichWheel == 3)
        {
            //after random has run, spins reel and displays final image in reel
            currentWheelValue3 = wheelPick
            spin(reel: reel3!, reelNum: 3)
            reel3?.texture = SKTexture(imageNamed: currentWheelValue3)
        }
    }
    
    //test value of wheels
    func testValues()
    {
        if (currentWheelValue1 == currentWheelValue2 && currentWheelValue2 == currentWheelValue3)
        {
            print ("congrats, you've hit the jackpot challenger")
        }
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
       
//        reel1?.Update()
//        reel2?.Update()
//        reel3?.Update()
    }
    
    
    
    
    
    
}
