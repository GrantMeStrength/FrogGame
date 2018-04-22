    //
    //  Frog Game
    //
    //
    //  Created by John Kennedy on 4/8/18.
    //  Copyright © 2018 craicdesign. All rights reserved.
    //
    
    import SpriteKit
    import GameplayKit
    
    class GameScene: SKScene, SKPhysicsContactDelegate {
        
        // Keep track of all sprites in the game
        var entities = Set<GKEntity>()
        
        private var lastUpdateTime : TimeInterval = 0
        private var livesText : SKLabelNode?
        private var scoreText : SKLabelNode?
        private var messageText : SKLabelNode?
        
        private var frogEntity : Frog?
        
        private let start_position : CGFloat = -488
        
        enum RowType : Int {
            case car
            case truck
            case safe
            case log
            case turtles
            case home
        }
        
        enum GameStates {
            case startgame
            case getready
            case gameover
            case losealife
            case froghome
            case frogcelebrate
            case playing
            case readytoplay
            case frogsplat
            case frogsplash
            case frogcrash
            case attractmode
        }
        
        private var gameState : GameStates = .startgame
        private var gameStateCounter = 0
        private var score = 0
        private var lives = 3
        
        private let rows : [RowType] = [.car, .truck, .car, .truck, .car, .safe, .turtles, .log, .log, .turtles, .log, .home]
        private let speeds : [CGFloat] = [120, -120, 100, -100, 90, 0, 80,-70,60,-70,90,0]
        
        func gameStateManager()
        {
            gameStateCounter = gameStateCounter + 1
            
            switch gameState
            {
            case .startgame:
                startGame()
                self.gameStateCounter = 0
                self.gameState = .getready
                displayMessage(text: "Get Ready!")
                frogEntity?.blinkFrog()
                
                
            case .gameover:
                if self.gameStateCounter > 120
                {
                    self.gameStateCounter = 0
                    self.gameState = .startgame
                    getReady()
                }
                
            case .getready:
                
                if self.gameStateCounter > 60
                {
                    frogEntity?.stopFrog()
                    self.gameStateCounter = 0
                    self.gameState = .playing
                    messageText?.alpha = 0
                    displayStatus()
                }
                
            case .frogsplash:
                frogEntity?.stopFrog()
                self.gameStateCounter = 0
                self.gameState = .losealife
                displayMessage(text: "Glub glub!")
                
            case .frogcrash:
                frogEntity?.stopFrog()
                self.gameStateCounter = 0
                self.gameState = .losealife
                displayMessage(text: "In use!")
                
            case .frogsplat:
                frogEntity?.stopFrog()
                self.gameStateCounter = 0
                self.gameState = .losealife
                displayMessage(text: "Splat!")
                
            case .losealife:
                if self.gameStateCounter > 60
                {
                    self.gameStateCounter = 0
                    self.lives = self.lives - 1
                    displayStatus()
                    if lives > 0
                    {
                        frogEntity?.blinkFrog()
                        self.gameState = .getready
                        getReady()
                    }
                    else
                    {
                        self.gameState = .gameover
                        displayMessage(text: "Game over")
                    }
                }
                
            case .froghome:
                score = score + 100
                displayStatus()
                self.gameStateCounter = 0
                self.gameState = .frogcelebrate
                displayMessage(text: "Made it!")
                //
                // ToDo: How many frogs are home? Is the level complete?
                //
                
            case .frogcelebrate:
                if self.gameStateCounter > 100
                {
                    self.gameStateCounter = 0
                    self.gameState = .getready
                    getReady()
                }
                
            default :
                ()
            }
            
        }
        
        func startGame()
        {
            // Everything to default state.
            score = 0
            lives = 3
            displayStatus()
            
            for entity in self.entities {
                if entity.component(ofType: SpriteComponent.self)?.node.name == "Pad"
                {
                    entity.component(ofType: SpriteComponent.self)?.node.alpha = 0.1
                }
            }
                
                
        }
        
        func getReady()
        {
            // Just about to start playing
            frogEntity?.resetFrog();
            displayMessage(text: "Get Ready!")
        }
        
        override func didMove(to view: SKView) {
            
            // Collisions delegate
            self.physicsWorld.contactDelegate = self
            
           
            
        }
        
        
    
        
        
        func displayStatus()
        {
            livesText?.text = "Lives: \(lives)"
            scoreText?.text = "Score: \(score)"
        }
        
        func displayMessage(text : String)
        {
            
            messageText?.alpha = 0.0
            messageText?.text = text.uppercased()
            
            let fadein = (SKAction.fadeIn(withDuration: 0.3))
            let fadeout = (SKAction.fadeOut(withDuration: 0.3))
            let wait = (SKAction.wait(forDuration: 1.0))
            
            messageText?.run(SKAction.sequence([fadein, wait, fadeout]))
            
        }
          
        override func sceneDidLoad() {
            
            self.lastUpdateTime = 0
            
            // Get sprites
            // If we were reading it from the GUI based SKS file, we'd use something like this:
            // frogEntity = Frog(sprite: (self.childNode(withName: "//frog") as? SKSpriteNode)!)
            // addEntityToScene(new_entity: frogEntity!)
            
            // Get text nodes, which are in the GUI based SKS page.
            self.scoreText = self.childNode(withName: "//Score") as? SKLabelNode
            self.livesText = self.childNode(withName: "//Lives") as? SKLabelNode
            self.messageText = self.childNode(withName: "//Message") as? SKLabelNode
            
            
            // Create spriteobjects traffic programmatically as the GUI sucks ass and crashes
            // At the moment using random numbers, but in the future must create array of actual values
            // to make the game fair and playable.
            
            frogEntity = Frog(imageName: "frog")
            frogEntity?.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: 0, y: -584)
            addEntityToScene(new_entity: frogEntity!)
            
            // Create all the rows of everything, including lilly pads, logs, turtles and cars
            
            var row_position_y = Int(start_position)
            
            for i in 0...11
            {
                switch rows[i] {
                    
                case .safe:
                    ()
                    
                    
                case .home :
                    
                    var padx : CGFloat = -300
                    
                    for _ in 0...4
                    {
                        let bank = Bank(imageName: "bank")
                        bank.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: padx, y: CGFloat(row_position_y))
                        addEntityToScene(new_entity: bank)
                        padx += 60
                        
                        let slp = Pad(imageName: "lillypad")
                        slp.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: padx, y: CGFloat(row_position_y))
                        addEntityToScene(new_entity: slp)
                        
                        padx += 60
                    }
                    
                    let bank = Bank(imageName: "bank")
                    bank.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: padx, y: CGFloat(row_position_y))
                    addEntityToScene(new_entity: bank)
                    
                case .car :
                    for j in 1...10 {
                        if (Int(arc4random_uniform(6)) > 4)
                        {
                            let car1 = Car(imageName: "car", speed: speeds[i])
                            car1.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: -500 + (j * 96), y: row_position_y)
                            addEntityToScene(new_entity:car1)
                        }
                    }
                    
                case .truck :
                    for j in 1...8 {
                        if (Int(arc4random_uniform(6)) > 4)
                        {
                            let truck = Truck(imageName: "truck", speed: speeds[i])
                            truck.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: -500 + (j * 140), y: row_position_y)
                            addEntityToScene(new_entity:truck)
                        }
                    }
                    
                case .log :
                    for j in 0...7 {
                        if (Int(arc4random_uniform(6)) > 3)
                        {
                            let log = Log(imageName: "log", speed: speeds[i])
                            log.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: -512 + (j * 128) + 64, y: row_position_y)
                            addEntityToScene(new_entity:log)
                        }
                        else
                        {
                            let water = Water(imageName: "water", speed: speeds[i])
                            water.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: -512 + (j * 128) + 64 , y: row_position_y)
                            addEntityToScene(new_entity:water)
                        }
                    }
                    
                case .turtles :
                    for j in 0...7 {
                        if (Int(arc4random_uniform(6)) > 3)
                        {
                            let turtle = Turtles(imageName: "turtles", speed: speeds[i])
                            turtle.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: -512 + (j * 128) + 64, y: row_position_y)
                            addEntityToScene(new_entity:turtle)
                        }
                        else
                        {
                            let water = Water(imageName: "water", speed: speeds[i])
                            water.component(ofType: SpriteComponent.self)?.node.position = CGPoint(x: -512 + (j * 128) + 64 , y: row_position_y)
                            addEntityToScene(new_entity:water)
                        }
                    }
                }
                
                row_position_y = row_position_y + 96
            }
        }
        
        
        // Helper to get the speed of the objects moving in the row where the frog is currently sitting
        func getRowAndSpeed() -> (RowType, CGFloat)
        {
            let i = Int(CGFloat((frogEntity?.getPosition().y)! - start_position + 48) / 96)
            
            if (i >= 0 && i < 12)
            {
                return (rows[i], speeds[i])
                
            }
            else
            {    return (.safe, 0)}
        }
        
        // Utility to take an entity and add it to the set of entities.
        // During the game loop, the entire set is asked to update itself, 1 by 1
        func addEntityToScene(new_entity : GKEntity)
        {
            self.entities.insert(new_entity)
            
            if let sprite = new_entity.component(ofType: SpriteComponent.self)?.node {
                
                // Need to add this check, as sprites that are added in the sks file
                // will already have a parent.
                if (sprite.parent != scene)
                {
                    scene?.addChild(sprite)
                }
            }
            
        }
        
        // Remove an entity. Not sure if I've done that yet.
        func removeEntityFromScene(entity : GKEntity)
        {
            if let sprite = entity.component(ofType: SpriteComponent.self)?.node {
                sprite.removeFromParent()
            }
            
            let index = entities.index(of: entity)
            self.entities.remove(at: index!)
        }
        
        // The user has tapped the screen. This usually means JUMP
        // but depending on gameState could do other things.
        
        func touchDown(atPoint pos : CGPoint) {
            
            frogEntity?.slide(speed: 0)
            
            if gameState != .playing
            {
                return
            }
            
            if (pos.y < 0)
            {
                frogEntity?.jump(direction: 96)
            }
            else
            {
                frogEntity?.jump(direction: -96)
            }
            
        }
        
        /*
        func touchMoved(toPoint pos : CGPoint) {
            
        }
        
        func touchUp(atPoint pos : CGPoint) {
            
        }
        */
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        }
        
        /*
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }
        */
     
      
        
        // Helper function to check for "A hit B" and "B hit A".
        
        func contactTest (name1 : String, target1 : String, name2 : String, target2 : String) -> Bool
        {
            if name1 == target1 && name2 == target2
            {
                return true
            }
            
            if name1 == target2 && name2 == target1
            {
                return true
            }
            
            return false
            
        }
        
        
        // Helper to test if either body in the collision is equal to 'target'
        func contactTest (objects: SKPhysicsContact, target: String) -> Bool
        {
            if objects.bodyA.node?.name == target || objects.bodyB.node?.name == target
            {
                return true
            }
            return false
        }
        
        // Collision detection event - end
        func didEnd(_ contact: SKPhysicsContact) {
            frogEntity?.slide(speed: 0)
        }
        
        // Collision detection event - begin
        func didBegin(_ contact: SKPhysicsContact) {
            
            
            // Did Frog Get home?
            if contactTest(objects: contact, target : "Pad") && gameState != .froghome && !frogEntity!.isFrogJumping()
            {
                
                if contact.bodyA.node?.name == "Pad"
                {
                    if ((contact.bodyA.node?.alpha)! < CGFloat(0.5))
                    {
                        contact.bodyA.node?.alpha = 1.0
                        gameState = .froghome
                    }
                    else
                    {
                        gameState = .frogcrash
                    }
                }
                else
                {
                    // Must be B
                    
                        if ((contact.bodyB.node?.alpha)! < CGFloat(0.5))
                        {
                            contact.bodyB.node?.alpha = 1.0
                            gameState = .froghome
                        }
                        else
                        {
                            gameState = .frogcrash
                        }
                    
                }
            }
            
            if contactTest(objects: contact, target: "Bank") && gameState != .froghome && !frogEntity!.isFrogJumping()
            {
                // Almost made it home
                gameState = .frogcrash
            }
            
            
            // Hit by car or truck? SPLAT
            
            if contactTest(objects: contact, target: "Vehicle")
            {
                // splat
               // gameState = .frogsplat
            }
            
            
            // Hit the water? - do we need this? If it's touching the log and it's in a water row,
            // it should be fine.
            
            if contactTest(objects: contact, target: "Water")
            {
                
                if !frogEntity!.isFrogJumping() {
                  //  gameState = .frogsplash
                }
            }

        }
        
        
        // Called every frame, more or less.
        override func update(_ currentTime: TimeInterval) {
            // Called before each frame is rendered
            
            gameStateManager()
            
            // Initialize _lastUpdateTime if it has not already been
            if (self.lastUpdateTime == 0) {
                self.lastUpdateTime = currentTime
            }
            
            // Calculate time since last update
            let dt = currentTime - self.lastUpdateTime
            
            
            // What is the Frog up to..
            let rowtype = getRowAndSpeed().0
            let rowspeed = getRowAndSpeed().1
            
            
            if gameState == .playing || gameState == .getready
            {
                if !(frogEntity?.isFrogJumping())!
                {
                    if rowtype == .log
                    {
                        frogEntity?.slide(speed: rowspeed)
                    }
                    
                    if rowtype == .turtles
                    {
                        frogEntity?.slide(speed: rowspeed)
                    }
                    
                }
                
                
                // Update entities
                for entity in self.entities {
                    
                    // Update all sprites
                    entity.update(deltaTime: dt)
                    
                    // Actions specific to some sprite types go here.
                    if entity.component(ofType: SpriteComponent.self)?.node.name == "Turtles"
                    {
                        (entity as! Turtles).AnimateTurtles()
                        
                        if (entity as! Turtles).underwater() && rowtype == .turtles
                        {
                            gameState = .frogsplash
                        }
                    }
                }
            }

            self.lastUpdateTime = currentTime
        }
    }
