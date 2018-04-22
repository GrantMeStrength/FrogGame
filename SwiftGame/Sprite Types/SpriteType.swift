import SpriteKit
import GameplayKit

// The class that all other sprites are inherited from.
// Handles loading them from an image or the SKS file, and
// adding the physics body for collisions.


class SpriteType: GKEntity {
    
    
    let sprite_Frog : UInt32 = 1
    let sprite_Log : UInt32 = 2
    let sprite_Car : UInt32 = 4
    let sprite_Water : UInt32 = 8
    let sprite_Turtle : UInt32 = 16
    let sprite_Pad : UInt32 = 32  // Good thing to touch
    let sprite_Bank : UInt32 = 64 // Bad thing to touch
   
    var speedVector : CGFloat = 0
    var contactMask : UInt32 = 0
    var collisionMask : UInt32 = 0
    var categoryMask : UInt32 = 0

    
    // A good explainer on these flags:
    // https://stackoverflow.com/questions/40593678/what-are-sprite-kits-category-mask-and-collision-mask
    
    // Init when used with existing sprite that's on the SKS designer
    init (sprite : SKSpriteNode, speed : CGFloat)
    {
        super.init()
        let spriteComponent = SpriteComponent(spriteNode: sprite)
        addComponent(spriteComponent)
        speedVector = speed
    }
    
    // Init when used with existing sprite that's on the SKS designer but not moving
    init (sprite : SKSpriteNode)
    {
        super.init()
        let spriteComponent = SpriteComponent(spriteNode: sprite)
        addComponent(spriteComponent)
        speedVector = 0
    }
    
    
    // Init when creating the sprite entirely programmatically
    init(imageName: String, speed: CGFloat) {
        super.init()
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 64, height: 64)
        addComponent(spriteComponent)
        speedVector = speed
    }
    
    // Init when creating the sprite image entirely programmatically but it's not moving: frog probably, or water
    init(imageName: String) {
        super.init()
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width: 64, height: 64)
        addComponent(spriteComponent)
    }
    
    // Add the code for collisions
    func addPhysicsBody(node : SKSpriteNode)
    {
        // Store the parent entity in the sprite
        node.entity = self
        
        // If there is no texture, use rectangle
        if let _ = node.texture
        {
            node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
            
            if (node.name == "Turtles")
            {
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
            }
            
        }
        else
        {
            node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        }
        node.physicsBody?.isDynamic = true          // required to get collision event.
        node.physicsBody?.affectedByGravity = false;
        node.physicsBody?.allowsRotation = false;
        
        node.physicsBody?.contactTestBitMask = contactMask
        node.physicsBody?.collisionBitMask = 0;     // collisionMask is zero which means the shape doesn't get pushed around, but collision event is raised.
        node.physicsBody?.categoryBitMask = categoryMask // Unique value per type of object e.g. frog = 1
    }
    
    
    func getPosition() -> (CGPoint)
    {
         let sprite = self.component(ofType: SpriteComponent.self)
        return (sprite?.node.position)!
    }
    
    // By default the sprites move left or right at speed, and wrap around.
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        if (speedVector == 0)
        {
            return;
        }
        
        let sprite = self.component(ofType: SpriteComponent.self)
        
       
        if (speedVector>0 && sprite?.node.name != "Frog" && sprite?.node.name != "Log" )
        {
            sprite?.node.zRotation = -3.14159
        }
        
        let current_position =  sprite?.node.position
        
        var new_position = CGPoint(x : (current_position?.x)! + CGFloat(seconds) * speedVector, y: (current_position?.y)!)
        
        if (new_position.x < (-512))
        {
            new_position.x = (512)
        }
        
        if (new_position.x > (512))
        {
            new_position.x = (-512)
        }
        
        sprite?.node.position = new_position
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
