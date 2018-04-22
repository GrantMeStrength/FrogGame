import SpriteKit
import GameplayKit


class Log: SpriteType
    
{
    
    
    // Init when creating the sprite entirely programmatically
    override init(imageName: String, speed: CGFloat) {
         super.init(imageName: imageName, speed: speed)
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 128, height: 96)
        addComponent(spriteComponent)
        speedVector = speed
        spriteComponent.node.zPosition = 2
        categoryMask = sprite_Log
        collisionMask = 0
        contactMask = sprite_Frog
        spriteComponent.node.name = "Log"
        addPhysicsBody(node: spriteComponent.node)
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
