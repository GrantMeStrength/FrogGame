import SpriteKit
import GameplayKit


class Water: SpriteType
    
{
    
    
    // Init when creating the sprite entirely programmatically
    override init(imageName: String, speed: CGFloat) {
        super.init(imageName: imageName, speed: speed)
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 72, height: 16)
        addComponent(spriteComponent)
        speedVector = speed
        spriteComponent.node.zPosition = 1
        categoryMask = sprite_Water
        collisionMask = 0
        contactMask = sprite_Frog
        addPhysicsBody(node: spriteComponent.node)
        spriteComponent.node.name = "Water"
        spriteComponent.node.alpha = 0.00 // Note: Although alpha is 0, collisions still register!
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
