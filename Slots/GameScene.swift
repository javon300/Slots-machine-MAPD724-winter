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
    private var reel1: Reel?
    private var reel2: Reel?
    private var reel3: Reel?
    
    private var plusBtn: Button?
    private var minusBtn: Button?
    private var spinBtn: Button?
    private var resetBtn: Button?
    private var quitBtn: Button?
    
    private var balanceLabel: SKLabelNode?
    private var balanceAmount: SKLabelNode?
    private var betLabel: SKLabelNode?
    private var betAmount: SKLabelNode?
    private var jackpotLabel: SKLabelNode?
    private var jackpotAmount: SKLabelNode?
    private var touchLocation: CGPoint?
    private var background: SKSpriteNode?
    private var currentWheelValue1: String = "star_bad"
    private var currentWheelValue2: String = "star_bad"
    private var currentWheelValue3: String = "star_bad"
    
    //variables for local data
    private var balance: Int = 1000
    private var amountToBet: Int = 0
    private var jackpot: Int = 10000
    
    

    
    //array of slot images
    private let slotOptions = ["slots_symbol_cherry", "slots_symbol_bell","slots_symbol_orange", "slots_symbol_7", "slot_symbol_grape", "star_good", "star_bad"]

    
    
                //***********************************??????  did move to view  ??????++++++++++++++++++++++++++++++++++//
    
    //did move to view (on instance created)
    override func didMove(to view: SKView)
    {
        name = "game"
        
        //initialize numbers in view
        betAmount?.text = String (amountToBet)
        balanceAmount?.text = String(balance)
        jackpotAmount?.text = String(jackpot)
        
        //add reels to screen
        reel1 = Reel()  //alloate memory  for variable
        reel1?.position = CGPoint(x: -204.378, y: 1.003)
        reel1?.size.width = CGFloat(161.648)
        reel1?.size.height = 510.224
        reel1?.zPosition = 1
        addChild(reel1!)
        
        reel2 = Reel()  //alloate memory  for variable
        reel2?.position = CGPoint(x: -2.63, y: 1.003)
        reel2?.size.width = 153.115
        reel2?.size.height = 510.224
        reel2?.zPosition = 1
        addChild(reel2!)
        
        reel3 = Reel()  //alloate memory  for variable
        reel3?.position = CGPoint(x: 191.879, y: 1.003)
        reel3?.size.width = 161.109
        reel3?.size.height = 510.224
        reel3?.zPosition = 1
        addChild(reel3!)
        
        //add buttons to view
        self.spinBtn = self.childNode(withName: "//spin")  as? Button
        spinBtn?.zPosition = 1      //about background
        
        self.minusBtn = self.childNode(withName: "//minus")  as? Button
        minusBtn?.zPosition = 1      //about background
      
        self.plusBtn = self.childNode(withName: "//plus")  as? Button
        plusBtn?.zPosition = 1      //about background
        
        self.quitBtn = self.childNode(withName: "//quit")  as? Button
        quitBtn?.zPosition = 1      //about background
        
        self.resetBtn = self.childNode(withName: "//quit")  as? Button
        resetBtn?.zPosition = 1      //above background
     
        // because using variables that are already on display no need to use addchild
        self.balanceLabel = self.childNode(withName: "//balance_label") as? SKLabelNode
        balanceLabel?.zPosition = 1      //above background
     
        
        self.balanceAmount = self.childNode(withName: "//balance_amount") as? SKLabelNode
        balanceAmount?.zPosition = 1      //above background
        
        self.betLabel = self.childNode(withName: "//bet_label") as? SKLabelNode
        betLabel?.zPosition = 1      //above background
        
        self.betAmount = self.childNode(withName: "//bet_amount") as? SKLabelNode
        betAmount?.zPosition = 1      //above background
        
        self.jackpotLabel = self.childNode(withName: "//jackpot_label") as? SKLabelNode
        jackpotLabel?.zPosition = 1      //above background
        
        self.jackpotAmount = self.childNode(withName: "//jackpot_amount") as? SKLabelNode
        jackpotAmount?.zPosition = 1      //above background
        
        self.background = self.childNode(withName: "//background") as? SKSpriteNode
      jackpotAmount?.zPosition = 0      //above background
    }
    
    
    
    //****************************************??????  Custom functions  ??????++++++++++++++++++++++++++++++++++++++++++++++++
    
    //spins a single wheel
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
        reel.run(SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 1.0),
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
                                                   ]), count: 4))
    }
    
    
    //determines what wheel to spin
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
            reel1?.texture = SKTexture(imageNamed: currentWheelValue1)
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
    
    //checks number of matches and print appropriate response
    func didYouWin()
    {
        // if 3 matches
        if (currentWheelValue1 == currentWheelValue2 && currentWheelValue2 == currentWheelValue3)
        {
            print ("congrats, you've hit the jackpot challenger")
            
            let alert = UIAlertController(title: "JackPot !!!", message: "You won a $10000 Jackpot!!!", preferredStyle:UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cheers !!", style: UIAlertAction.Style.default, handler: nil))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
            //money calculations
            balance += jackpot
            balanceAmount?.text = String (balance)
        }
        //if 2 matches
        else if (currentWheelValue1 == currentWheelValue2 || currentWheelValue1 == currentWheelValue3 || currentWheelValue2 == currentWheelValue3)
        {
            print ("only two matches not quite there yet")
            
            let alert = UIAlertController(title: "🤪", message: "you won a lil supm supm", preferredStyle:UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cheers !!", style: UIAlertAction.Style.default, handler: nil))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
            //money calculations
            balance += amountToBet * 2
            balanceAmount?.text = String (balance)
        }
        //if loose
        else
        {
            print("you lost this round place bet and try again")
            
            //money calculation
            balance -= amountToBet
            balanceAmount?.text = String (balance)
            betAmount?.text = "0"
        }
            
}
    

    func touchDown(atPoint pos : CGPoint){}
    func touchMoved(toPoint pos : CGPoint){}
    func touchUp(atPoint pos : CGPoint){touchLocation = pos}
    
    
    
    
    
    //**************************************??????  overridden funmctions  ??????++++++++++++++++++++++++++++++++++++++++++++++
    
    
    
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        print("spin btntapped!")
        //guard let touch = touches.first else { return }
        for touch in touches {
            //self.touchUp(atPoint: touch.location(in: self))
            //self.touchUp(atPoint: touchLocation!)
            
            // Current node - Node that is clicked
            let current_node = atPoint(touch.location(in: self))
            
                print(current_node)
            //if spin is selected
            if  (current_node.name == "spin")
            {
                if (amountToBet == 0)
                {
                    let alert = UIAlertController(title: "No initial bet", message: "You need to enter bet amount to play", preferredStyle:UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    print("you need to enter bet amount")
                }
                else
                {
                    //if won
                    print("spin btntapped!")
                    spinWheel(whichWheel: 1) //spins wheel on created object (testing)
                    spinWheel(whichWheel: 2) //spins wheel on created object (testing)
                    spinWheel(whichWheel: 3) //spins wheel on created object (testing)
                    
                    //check if user won
                    didYouWin()
                }
                
            }
            //if decrease bet is selected
            if  (current_node.name == "minus")
            {
                if (amountToBet < 0  || amountToBet == 0)
                {
                    print("amount is already zero")
                    amountToBet = 0
                    betAmount?.text = String (amountToBet)
                    
                }
                else
                {
                    amountToBet -= 100
                    balance += 100
                    betAmount?.text = String (amountToBet)
                    balanceAmount?.text = String(balance)
                    print("amount decreased")
                }
            }
            //if increase is selected
            if  (current_node.name == "plus")
            {
                if (balance < 0  || balance == 0)
                {
                    print("you have no more money to bet")
                    balanceAmount?.text = String (balance)
                }
                else
                {
                    
                    amountToBet += 100
                    balance -= 100

                    betAmount?.text = String (amountToBet)
                    balanceAmount?.text = String(balance)
                    print("amount increased")
                }
            }
            //if reset is selected
            if  (current_node.name == "reset")
            {
                // Reset money values and there display
                balance = 1000
                amountToBet = 0
                balanceAmount?.text = String(balance)
                betAmount?.text = String(amountToBet)
            }
            //if quit is selected
            if  (current_node.name == "quit")
            {
                // Quit button - Exit app
                exit(0)
            }
        }
    }

               
           
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {}
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
       
       override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
           for t in touches { self.touchUp(atPoint: t.location(in: self)) }
       }
       
       override func update(_ currentTime: TimeInterval) {
           // Called before each frame is rendered
       }
    
    
    
    
    
    
}
