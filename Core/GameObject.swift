

import GameplayKit
import SpriteKit

class GameObject: SKSpriteNode, GameProtocol
{
    
    //public instance members
    var verticalSpeed: CGFloat?
    
    var width: CGFloat?
    var height: CGFloat?
    
    var scale: CGFloat?
    
    //constructor/ initializer
    //super class for various game objects
    init (imageString: String, initialScale: CGFloat)
    {
        //texture is an image
        let texture = SKTexture(imageNamed: imageString)
        let color = UIColor.white
        
        super.init(texture: texture, color: color, size: texture.size())
        
        scale = initialScale
        setScale(scale!)
        width = texture.size().width * scale!
        height = texture.size().height * scale!
       
        //used to identify game object in other parts of code
        name = imageString

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Reset()
    {
        
    }
    
    func Start()
    {
        
    }
    
    func Update()
    {
        
    }
    
 
}
