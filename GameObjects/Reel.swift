import GameplayKit
import SpriteKit

class Reel: GameObject
{
    //variables from gamescene.sks
    //reels to be spon
    private var reel1 : SKSpriteNode?
    private var reel2 : SKSpriteNode?
    private var reel3 : SKSpriteNode?
    //constructor
    init()
    {
        // Get label node from scene and store it for use later
        reel1 = self.childNode(withName: "//reell") as? SKSpriteNode
        super.init(imageString: "star_bad", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //life cycle functions()
    override func CheckBounds()
    {
        if (position.y <= -773)
        {
            Reset()
        }
    }
    
    override func Reset()
    {
        position.y = 773
    }
    
    //initialization
    override func Start()
    {
        zPosition = 0
        verticalSpeed = 5.0
    }
    
    override func Update()
    {
        Move()
        CheckBounds()
    }
    
    func Move()
    {
        position.y -= verticalSpeed!
    }
    
}
