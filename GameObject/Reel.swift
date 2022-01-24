import GameplayKit
import SpriteKit

class Reel: GameObject
{
    //constructor
    init()
    {
        super.init(imageString: "star_bad", initialScale: 1.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //life cycle functions()
    override func Reset()
    {
        //sets to first image
    }
    
    //initialization
    override func Start()
    {
        zPosition = 2
        verticalSpeed = 7.0
    }
    
    override func Update()
    {
        Move()
    }
    
    func Move()
    {
        
    }
    
}
