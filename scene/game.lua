------------------------------------------------------------------------------------------------
-- The Game module.
--
-- @module  game
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Mar-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES                                             --                
-- ------------------------------------------------------------------------------------------ --
 
local composer  = require 'composer' 
local stars     = require 'scene.game.lib.stars' 

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION                                       --                 
-- ------------------------------------------------------------------------------------------ --

local scene = composer.newScene()

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --   
-- ------------------------------------------------------------------------------------------ --

local movingStars = {} 
local numStar = 800  

function scene:create( event )
 
   local sceneGroup = self.view
  
   for i=1, numStar do

      -- Create new star
      movingStars[i] = stars.new()

   end

   -- Increase speed to make stars move faster:)
   scene.speed = 20

end

local function enterFrame( event )

   for i=1, numStar do


      movingStars[i]:update()
   
   end

end 
 
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if phase == 'will' then

      -- Add listener
      Runtime:addEventListener( 'enterFrame', enterFrame )

   elseif phase == 'did' then

   end

end
 
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if phase == 'will' then

   elseif phase == 'did' then

      -- Remove listener
      Runtime:removeEventListener( 'enterFrame', enterFrame )

   end
   
end

function scene:destroy( event )
 
end
 
scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
 
return scene