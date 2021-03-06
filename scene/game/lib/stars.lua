------------------------------------------------------------------------------------------------
-- The Stars module.
--
-- @module  stars
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Mar-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION	                                      --						
-- ------------------------------------------------------------------------------------------ --

local M = {}

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES	                                          --						
-- ------------------------------------------------------------------------------------------ --

local composer = require 'composer' 

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --	
-- ------------------------------------------------------------------------------------------ --

local mRandom = math.random
local mMax    = math.max

local _T      = display.screenOriginY
local _B  	  = display.viewableContentHeight - display.screenOriginY
local _L  	  = display.screenOriginX
local _R  	  = display.viewableContentWidth - display.screenOriginX
local _CX 	  = display.contentCenterX
local _CY 	  = display.contentCenterY

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --	
-- ------------------------------------------------------------------------------------------ --

------------------------------------------------------------------------------------------------
--- Re-maps a number from one range to another. 
--
-- @param value	The incoming value to be converted.
-- @param start1 Lower bound of the value's current range.
-- @param stop1	Upper bound of the value's current range.
-- @param start2 Lower bound of the value's target range.
-- @param stop2	Upper bound of the value's target range.
-- @return Remapped number.
------------------------------------------------------------------------------------------------
local function map( value, start1, stop1, start2, stop2 )

	return ( ( start2 - stop2 ) / ( start1 - stop1 ) * ( value - start1 ) + start2 )
	
end	

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --	
-- ------------------------------------------------------------------------------------------ --

------------------------------------------------------------------------------------------------
-- Constructor function of Stars module.
--
-- @return The star instance.
------------------------------------------------------------------------------------------------
function M.new()

	-- Get the current scene
	local scene = composer.getScene( composer.getSceneName( 'current' ) )
	local parent = scene.view

	local width = mMax( _B - _T, _R - _L )
	local height = width * 0.5

	local star = {}
	star.x = mRandom( -width, width )
  	star.y = mRandom( -height, height )
  	star.z = mRandom( width )
  	star.pz = star.z

	function star:update()

		-- Remove old star
		self:destroy()

		self.z = self.z - scene.speed
	    if self.z < 1 then

			self.z = width
			self.x = mRandom( -width, width )
			self.y = mRandom( -height, height )
			self.pz = self.z

	    end

	    local sx = map( self.x / self.z, 0, 1, 0, width )
	    local sy = map( self.y / self.z, 0, 1, 0, height )
	    local radius = map( self.z, 0, width, 4, 0 )
	    -- Create new circle
	    star.circle = display.newCircle( parent, sx, sy, radius ) 
	    star.circle:translate( _CX, _CY )

	    local px = map( self.x / self.pz, 0, 1, 0, width )
	    local py = map( self.y / self.pz, 0, 1, 0, height )
	    -- Create new line
	    star.line = display.newLine( parent, px, py, sx, sy )
	    star.line:translate( _CX, _CY )

	    self.pz = self.z

	end	

	function star:destroy()

		if self.line then
			-- Remove old line
			display.remove( self.line )
			self.line = nil
		end

		if self.circle then
			-- Remove old circle
			display.remove( self.circle )
			self.circle = nil
		end

	end	

	return star
	
end	

return M