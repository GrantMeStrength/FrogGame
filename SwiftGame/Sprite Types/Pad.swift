import SpriteKit
import GameplayKit


class Pad: SpriteType
    
{
    
    
    // Init when creating the sprite entirely programmatically
    override init(imageName: String) {
        super.init(imageName : imageName)
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 80, height: 96)
        addComponent(spriteComponent)
        speedVector = 0
        spriteComponent.node.zPosition = 2
        categoryMask = sprite_Pad
        collisionMask = 0
        contactMask = sprite_Frog
        spriteComponent.node.name = "Pad"
        addPhysicsBody(node: spriteComponent.node)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
