import SpriteKit
import GameplayKit


class Bank: SpriteType {
    
   
    // Init when creating the sprite entirely programmatically
    override init(imageName: String) {
        super.init(imageName : imageName)
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 40, height: 96)
        spriteComponent.node.zPosition = 2
        addComponent(spriteComponent)
        categoryMask = sprite_Bank
        collisionMask = 0
        contactMask = sprite_Frog
        spriteComponent.node.name = "Bank"
        speedVector = 0
        addPhysicsBody(node: spriteComponent.node)
    }
    
    
   
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
