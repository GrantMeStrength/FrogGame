import SpriteKit
import GameplayKit


class Frog: SpriteType {
    

    var frogJumping : Bool = false
    let frogStartY : CGFloat = -584
    
    var spriteNode : SKSpriteNode = SKSpriteNode()
    
    // Init when creating the sprite entirely programmatically
    override init(imageName: String) {
        super.init(imageName : imageName)
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
    
        spriteNode = spriteComponent.node
        spriteNode.size = CGSize(width: 64, height: 64)
        spriteNode.zPosition = 4
        addComponent(spriteComponent)
        
        categoryMask = sprite_Frog
        collisionMask = 0
        contactMask = sprite_Frog + sprite_Car + sprite_Log + sprite_Turtle + sprite_Pad + sprite_Bank
        spriteNode.name = "Frog"
        
        speedVector = 0
        
        addPhysicsBody(node: spriteNode)
    }
    
    func stopFrog()
    {
        spriteNode.removeAllActions()
        spriteNode.alpha = 1.0
        self.frogJumping = false
    }
    
    func resetFrog()
    {
        spriteNode.position = CGPoint(x: 0, y: frogStartY)
        self.speedVector = 0
        self.frogJumping = false
        spriteNode.size = CGSize(width: 64, height: 64)
    }
    
    
    func slide(speed : CGFloat)
    {
        speedVector = speed
        
    }
    
    
    func blinkFrog()
    {
        let scaleBlinkOut = SKAction.fadeOut(withDuration: 0.01)
        let pause = SKAction.wait(forDuration: 0.25)
        let scaleBlinkIn = SKAction.fadeIn(withDuration: 0.01)
        let blinkPattern = SKAction.sequence([scaleBlinkOut, pause, scaleBlinkIn, pause])
        spriteNode.run(SKAction.repeatForever(blinkPattern))
    }

    
    func jump(direction : CGFloat)
    {
        
        if self.frogJumping
        {
            return 
        }
        
        // Stop any sliding
        speedVector = 0
    
         frogJumping = true
      
        let updateJumping = SKAction.run { self.frogJumping = false }
        let scaleAction = SKAction.scale(by: 1.15, duration: 0.1)
        let reverseScaleAction = scaleAction.reversed()
        let jumpAction = SKAction.moveBy(x: 0, y: direction, duration: 0.2)
        let jumpScale = SKAction.sequence([scaleAction, reverseScaleAction])
        let jumpToStart = SKAction.moveTo(y: frogStartY, duration: 0.1)
        var jumpGroup = SKAction.group([jumpAction, jumpScale])
       
        // Check if player trying to go backwards
        if fabs((spriteNode.position.y) - frogStartY) < 16 && direction < 0
        {
            jumpGroup = SKAction.group([jumpToStart, jumpScale])
        }
        
        spriteNode.run(SKAction.sequence([jumpGroup, updateJumping]), withKey: "Jumping")


    }
    
   
    func isFrogJumping() -> Bool
    {
      //  let sprite = self.component(ofType: SpriteComponent.self)
        if spriteNode.action(forKey: "Jumping") == nil
        {
            return false // no longer jumping
        }
        else
        {
            return true // jumping
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
