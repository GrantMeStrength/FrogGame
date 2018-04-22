
import SpriteKit
import GameplayKit


class SpriteComponent: GKComponent {
    
  
    let node: SKSpriteNode
    
    // From an existing sprite
    init(spriteNode : SKSpriteNode)
    {
        node = spriteNode
        super.init()
    }
   
    // Initializer used to create sprite programmatically rather than the SKS file
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
