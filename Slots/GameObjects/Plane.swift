import GameplayKit
import SpriteKit

class Plane: GameObject
{
    //initializer
    init()
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //lifecycly functions
    override func CheckBounds()
    {
        //constraints on leeft boundary
        if (position.x <= -310)
        {
            position.x = -310
        }
        
        //constraints on right boundary
        if (position.x >= 310)
        {
            position.x =  310
        }
    }
    
    
    //initialization
    override func Start()
    {
        zPosition = 2
    }
    
    override func Update()
    {
        CheckBounds()
    }
    
    func TouchMove(newPos: CGPoint)
    {
        position = newPos
    }
    
}
