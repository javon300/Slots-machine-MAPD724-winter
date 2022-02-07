import SpriteKit

class Button: GameObject
{
    var defaultButton: SKSpriteNode

   public var imgString: String = ""
    //button takes an image, an action and a index value
    init(imageSting: String)
    {
        defaultButton = SKSpriteNode()
        defaultButton.color = UIColor.white
        if (imgString == "")
        {
        //defaultButton.color: UIColor.
            super.init(imageString: imageSting, initialScale: 1.0)
            
        }
        else{
            super.init(imageString: self.imgString, initialScale: 1.0)
            
        }
        Start()
       
        isUserInteractionEnabled = true
    }
    init()
    {
        defaultButton = SKSpriteNode()
        defaultButton.color = UIColor.white
        super.init(imageString: self.imgString, initialScale: 1.0)
    }
   
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
     
       //Initialization
       override func Start()
       {
           //layering top of each other
           zPosition = 1
       }

}



