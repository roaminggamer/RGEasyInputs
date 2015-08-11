RGEasyInputs
============

(These modules require SSK be present and loaded to work.)

RGEasyInputs (part of the SSK library) is a collection of modules to create/destroy these input objects:

 * oneTouch.lua - One-touch input.
 * twoTouch.lua - Two-touch input.
 * oneStick.lua - Single full screen accessible joystick.
 * twoStick.lua - Twin stick (one for each half of the screen.)
 * oneStickOneTouch.lua - One-touch input on half the screen, joystick on the other half.  (Sides selectable.)
 * cornerButtons.lua - Two triangular buttons in lower left (or right) corner of screen.
 

The input objects created by these modules:
 * Produce global named events for modular ease-of-use via Runtime:dispatchEvent() calls.
 * Automatically adjust to handle device size and orientation.
 * Provide visual debug feedback for testing and confirmation of setup.

Before Running Samples!
============
Before you run the samples, copy the latest version of 'ssk' and the 'RGEasyInputs' folder into the individual samples.


One-Touch Basic Usage
-------------------------

##### Require the code
```lua
local easyInputs = require "RGEasyInputs.loadEasyInputs"
```

##### Create Input
```lua
local group = display.newGroup()
easyInputs.oneTouch.create( group, { debugEn = true, keyboardEn = true } )
```

##### Named Parameters
 * debugEn (false)- Show visual feedback.
 * fill ({1,0,0})- Table containing fill color for debug feedback.
 * alpha (0.25) - Alpha value used when showing debug feedback.
 * eventName ("onOneTouch") - Name to use for globally dispatched touch event.
 * keyboardEn (false) - If 'true' and simulating Android device, 'W' and 'up' keys will trigger event.

##### Catch Input
```lua
-- Start listenering for the one touch event
ball.onOneTouch = function( self, event )
	if( self.removeSelf == nil ) then
		ignore( "onOneTouch", self )
		return 
	end

	if( event.phase == "began" ) then
		ball:applyLinearImpulse( 0, -15, ball.x, ball.y )
	end
	return false
end; listen( "onOneTouch", ball )
```


Two-Touch Basic Usage
-------------------------

##### Require the code
```lua
local easyInputs = require "RGEasyInputs.loadEasyInputs"
```

##### Create Input
```lua
local group = display.newGroup()
easyInputs.twoTouch.create( group, { debugEn = true, keyboardEn = true } )
```

##### Named Parameters
 * debugEn (false)- Show visual feedback.
 * fill ({1,0,0})- Table containing fill color for debug feedback.
 * alpha (0.25) - Alpha value used when showing debug feedback.
 * leftEventName ("onTwoTouchLeft") - Name to use for globally dispatched touch event.
 * rightEventName ("onTwoTouchRight") - Name to use for globally dispatched touch event.
 * keyboardEn (false) - If 'true' and simulating Android device, 'A', 'D' and 'left', and 'right' keys will trigger events.

##### Catch Input
```lua
-- Start listenering for the two touch event
ball.onTwoTouchLeft = function( self, event )
	if( self.removeSelf == nil ) then
		ignore( "onTwoTouchLeft", self )
		return 
	end
	if( event.phase == "began" ) then
		ball:applyLinearImpulse( 15, -15, ball.x, ball.y )
	end
	return false
end; listen( "onTwoTouchLeft", ball )

ball.onTwoTouchRight = function( self, event )
	if( self.removeSelf == nil ) then
		ignore( "onTwoTouchRight", self )
		return 
	end
	if( event.phase == "began" ) then
		ball:applyLinearImpulse( -15, -15, ball.x, ball.y )
	end
	return false
end; listen( "onTwoTouchRight", ball )
```


One-Stick Basic Usage
-------------------------

##### Require the code
```lua
local easyInputs = require "RGEasyInputs.loadEasyInputs"
```

##### Create Input
```lua
local group = display.newGroup()
easyInputs.oneStick.create( group, { debugEn = true, joyParams = { doNorm = true } } )
```

##### Named Parameters
 * debugEn (false)- Show visual feedback.
 * fill ({1,0,0})- Table containing fill color for debug feedback.
 * alpha (0.25) - Alpha value used when showing debug feedback.
 * eventName ("onJoystick") - Name to use for globally dispatched touch event.
 * joyParams - Parameters to pass to the joystick builder.

##### Named 'joyParams' Parameters 
 * outerRadius (60) - Radius of outer joystick ring.
 * outerImg (nil) - Image to use for outer ring (display.newCircle() if not specified).
 * outerFill ({1,1,1,1}) - Fill color of outer joystick ring. 
 * outerStrokeColor ({0.25,0.25,0.25,1}) - Stroke color of outer joystick ring. 
 * outerStrokeWidth (4) - Stroke width of outer joystick ring. 
 * outerAlpha (1) - Alpha of outer joystick ring. 
 * stickRadius (outerRadius/2) - Similar to 'outer ring', but for stick.
 * stickImg (nil) - Similar to 'outer ring', but for stick.
 * stickFill ({1,1,1,1}) - Similar to 'outer ring', but for stick.
 * stickStrokeColor ({0.25,0.25,0.25,1}) - Similar to 'outer ring', but for stick.
 * stickStrokeWidth (0) - Similar to 'outer ring', but for stick.
 * stickAlpha (1) - Similar to 'outer ring', but for stick.
 * deadZoneRadius (outerRadius/2) - Similar to 'outer ring', but for deadZone.
 * deadZoneImg (nil) - Similar to 'outer ring', but for deadZone.
 * deadZoneFill ({1,1,1,1}) - Similar to 'outer ring', but for deadZone.
 * deadZoneStrokeColor ({0.25,0.25,0.25,1}) - Similar to 'outer ring', but for deadZone.
 * deadZoneStrokeWidth (0) - Similar to 'outer ring', but for deadZone.
 * deadZoneAlpha (1) - Similar to 'outer ring', but for deadZone.
 * doNorm (false) - Pass normalized joystick vector as extra info in joystick event.



##### Catch Input
```lua
ball.onJoystick = function( self, event )
	if( self.removeSelf == nil) then
		ignore( "onJoystick", self )
		return 
	end
	if( event.state == "on" ) then
		self.forceX = 15 * event.nx
		self.forceY = 15 * event.ny
		self.rotation = event.angle
	elseif( event.state == "off" ) then
		self.forceX = 0
		self.forceY = 0

	end
	return false
end; listen( "onJoystick", ball )
```

##### Joystick Event Parameters
 * phase - Normal (touch) 'began', 'moved', 'ended' phases.
 * angle - EFM
 * vx / vy - Vector values from joystick center to finger position.
 * nx / ny - Normalized nx / ny values if doNorm is 'true'.
 * percent - 0.0 .. 1.0, where 1.0 means the stick is 100% to the outer ring. Note: 0.0 starts at edge of deadZone and increases outward.
 * state - 'off' if stick is not past edge of deadZone.  'on' otherwise.



Two-Stick Basic Usage
-------------------------

##### Require the code
```lua
local easyInputs = require "RGEasyInputs.loadEasyInputs"
```

##### Create Input
```lua
local group = display.newGroup()
easyInputs.twoStick.create( group, { debugEn = true, joyParams = { doNorm = true } } )
```

##### Named Parameters
 * debugEn (false)- Show visual feedback.
 * leftFill ({0,0,1})- Table containing fill color for left joystick debug feedback.
 * rightFill ({1,0,0})- Table containing fill color for right joystick debug feedback.
 * alpha (0.25) - Alpha value used when showing debug feedback.
 * leftEventName ("onLeftJoystick") - Name to use for globally dispatched touch event.
 * rightEventName ("onRightJoystick") - Name to use for globally dispatched touch event.
 * leftJoyParams - Parameters to pass to the left-joystick builder.
 * rightJoyParams - Parameters to pass to the right-joystick builder.

##### Named '*JoyParams' Parameters 
 * outerRadius (60) - Radius of outer joystick ring.
 * outerImg (nil) - Image to use for outer ring (display.newCircle() if not specified).
 * outerFill ({1,1,1,1}) - Fill color of outer joystick ring. 
 * outerStrokeColor ({0.25,0.25,0.25,1}) - Stroke color of outer joystick ring. 
 * outerStrokeWidth (4) - Stroke width of outer joystick ring. 
 * outerAlpha (1) - Alpha of outer joystick ring. 
 * stickRadius (outerRadius/2) - Similar to 'outer ring', but for stick.
 * stickImg (nil) - Similar to 'outer ring', but for stick.
 * stickFill ({1,1,1,1}) - Similar to 'outer ring', but for stick.
 * stickStrokeColor ({0.25,0.25,0.25,1}) - Similar to 'outer ring', but for stick.
 * stickStrokeWidth (0) - Similar to 'outer ring', but for stick.
 * stickAlpha (1) - Similar to 'outer ring', but for stick.
 * deadZoneRadius (outerRadius/2) - Similar to 'outer ring', but for deadZone.
 * deadZoneImg (nil) - Similar to 'outer ring', but for deadZone.
 * deadZoneFill ({1,1,1,1}) - Similar to 'outer ring', but for deadZone.
 * deadZoneStrokeColor ({0.25,0.25,0.25,1}) - Similar to 'outer ring', but for deadZone.
 * deadZoneStrokeWidth (0) - Similar to 'outer ring', but for deadZone.
 * deadZoneAlpha (1) - Similar to 'outer ring', but for deadZone.
 * doNorm (false) - Pass normalized joystick vector as extra info in joystick event.



##### Catch Input
```lua
ball.onLeftJoystick = function( self, event )
	if( self.removeSelf == nil ) then
		ignore( "onLeftJoystick", self )
		return 
	end
	if( event.state == "on" ) then
		self.forceX = 15 * event.nx
		self.forceY = 15 * event.ny
	elseif( event.state == "off" ) then
		self.forceX = 0
		self.forceY = 0

	end
	return false
end; listen( "onLeftJoystick", ball )


ball.onRightJoystick = function( self, event )
	if( self.removeSelf == nil ) then
		ignore( "onRightJoystick", self )
		return 
	end
	self.rotation = event.angle
	return false
end; listen( "onRightJoystick", ball )
```

##### Joystick Event Parameters
 * phase - Normal (touch) 'began', 'moved', 'ended' phases.
 * angle - EFM
 * vx / vy - Vector values from joystick center to finger position.
 * nx / ny - Normalized nx / ny values if doNorm is 'true'.
 * percent - 0.0 .. 1.0, where 1.0 means the stick is 100% to the outer ring. Note: 0.0 starts at edge of deadZone and increases outward.
 * state - 'off' if stick is not past edge of deadZone.  'on' otherwise.



Corner Buttons Basic Usage
-------------------------
Tip: Can be created twice for four buttons.

##### Require the code
```lua
local easyInputs = require "RGEasyInputs.loadEasyInputs"
```

##### Create Input
```lua
local group = display.newGroup()
easyInputs.cornerButtons.create( group, { debugEn = true, keyboardEn = true } )
```

##### Named Parameters
 * debugEn (false)- Show visual feedback.
 * button1Fill ({1,0.55,0.55,1})- Table containing fill color for button 1 debug feedback.
 * button2Fill ({0,1,1,1})- Table containing fill color for button 2 debug feedback.
 * button1Mask/button2Mask (see comment) - Masks to use for buttons.  Defaults to: "RGEasyInputs/halftouchA1M.png" and "RGEasyInputs/halftouchA2M.png" respectively.  See 'RGEasyInputs' folder for other options.
 * alpha (0.25) - Alpha value used when showing debug feedback.
 * button1EventName ("onButton1") - Name to use for globally dispatched touch event.
 * button2EventName ("onButton2") - Name to use for globally dispatched touch event.
 * leftJoyParams - Parameters to pass to the left-joystick builder.
 * keyboardEn (false) - If 'true' and simulating Android device, 'D'/ 'right' keys will trigger button 1 event, and 'A'/'left' will trigger button 2 event.
 * startRight (true) - If 'true' buttons are on right-bottom side of screen, else left-bottom.
 * xOffset / yOffset - < x, y > values to offset buttons by.



##### Catch Input
```lua
-- Start listenering for the two touch event
--
ball.onButton1 = function( self, event )
	if( self.removeSelf == nil ) then
		ignore( "onButton1", self )
		return 
	end
	if( event.phase == "began" ) then
		ball:applyLinearImpulse( 15, -15, ball.x, ball.y )
	end
	return false
end; listen( "onButton1", ball )

ball.onButton2 = function( self, event )
	if( self.removeSelf == nil ) then
		ignore( "onButton2", self )
		return 
	end
	if( event.phase == "began" ) then
		ball:applyLinearImpulse( -15, -15, ball.x, ball.y )
	end
	return false
end; listen( "onButton2", ball )
```
