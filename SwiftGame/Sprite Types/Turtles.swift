import SpriteKit
import GameplayKit


class Turtles: SpriteType
    
{
    
    var submergeCounter = 0
    
    // Init when creating the sprite entirely programmatically
    override init(imageName: String, speed: CGFloat) {
        super.init(imageName: imageName, speed: speed)
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 128, height: 64)
        addComponent(spriteComponent)
        speedVector = speed
        spriteComponent.node.zPosition = 2
        categoryMask = sprite_Turtle
        collisionMask = 0
        contactMask = sprite_Frog
        spriteComponent.node.name = "Turtles"
        addPhysicsBody(node: spriteComponent.node)
        
        
    }
    
    func underwater () -> Bool
    {
         let sprite = self.component(ofType: SpriteComponent.self)
        
        if sprite?.node.alpha == 0
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func AnimateTurtles() {
       
         let sprite = self.component(ofType: SpriteComponent.self)
        
            submergeCounter = submergeCounter + 1
            
            switch submergeCounter
            {
                
            case 0..<60:
                sprite?.node.alpha = 1.0
                
            case 60..<80:
                sprite?.node.alpha = 0.7
                
            case 80..<100:
                sprite?.node.alpha = 0.3
                
            case 100..<140:
                sprite?.node.alpha = 0.0
                
            case 140..<160:
                sprite?.node.alpha = 0.3
                
            case 160..<180:
                sprite?.node.alpha = 0.7
                
            case 200..<210:
                sprite?.node.alpha = 1.0
                submergeCounter = 0
                
            default:
                sprite?.node.alpha = 1.0
                
        }
            
    }
        
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
