import SpriteKit
import GameplayKit


class Truck: SpriteType {
    
    // Init when creating the sprite entirely programmatically
    override init(imageName: String, speed: CGFloat) {
        
       super.init(imageName: imageName, speed: speed)
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 128, height: 64)
        addComponent(spriteComponent)
        speedVector = speed
        spriteComponent.node.zPosition = 3
        categoryMask = sprite_Car
        collisionMask = 0
        contactMask = sprite_Frog
        addPhysicsBody(node: spriteComponent.node)
        spriteComponent.node.name = "Vehicle"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
