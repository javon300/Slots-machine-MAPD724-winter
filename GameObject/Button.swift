import SpriteKit

class Button: GameObject
{
    var defaultButton: SKSpriteNode
    //var action: (Int) -> ()
    //var index: Int
    
    //button takes an image, an action and a index value
    init(imageSting: String)
    {
        defaultButton = SKSpriteNode()
        defaultButton.color = UIColor.white
        
        //defaultButton.color: UIColor.
        super.init(imageString: imageSting, initialScale: 1.0)
        Start()
       
        isUserInteractionEnabled = true
    }
   
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    //touches functionality overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        //sets a degree of tranparency
        defaultButton.alpha = 0.75
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.location(in: self)
        
        //if button has the location that has been touched then keep button transparent
        if defaultButton.contains(location)
        {
            defaultButton.alpha = 0.75
        }//else remove transparency
        else
        {
            defaultButton.alpha = 1.0
            
        }
            
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.location(in: self)
        
        //cecks if finger was lifted while on the button
        if defaultButton.contains(location)
        {
            //action(index)
        }
        defaultButton.alpha = 1.0
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
        //verticalSpeed = 7.0
    }
    
    override func Update()
    {
    
    }
    
    func Move()
    {
        
    }

    ////button takes an image, an action and a index value
    //init(buttonImage: String, action: @escaping (Int) ->(), index: Int)
    //{
    //    defaultButton = SKSpriteNode(imageNamed: buttonImage)
    //    self.action = action
    //    self.index = index
    //
    //    super.init(texture:nil, color: UIColor.clear, size: defaultButton.size)
    //
    //    //permits user touches
    //    isUserInteractionEnabled = true
    //
    //    addChild(defaultButton)
    //}

}



