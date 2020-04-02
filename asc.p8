pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--ascender
--by goon

--init, update, draw

--init
function _init()
 
end

--update
function _update60()
  p_mv()
  
end


function _draw()
  cls()
  draw_p()
  draw_grnd()
  rectfill(0,0,40,40, 2)
  print(p.landed,0,0,7)
  print(p.jump,0,6,7)
  print(curr_y,0,12,7)
  print(p.dx,0,22,7)
  print(p.overlap,0, 28, 7)
end

-->8
--tables

--player table

p={
  x=0,
  y=111,
  dx=0,
  dy=0,
  max_dx=3,
  max_dy=4,
  alive=true,
  speed=3,
  w=8,
  h=8,
  gravity=2,
  friction=.75,
  jumpframe=0,
  acc=0.75,
  boost=55,
  landed=true,
  jump=false,
  overlap=0,
}

--ground table

grnd={
  x=0,
  y=120,
  w=127,
  h=2,
}

--platform table
plat={}
-->8
--draw 

function draw_p()
  rectfill(p.x, p.y, p.x+p.w, p.y+p.h, 3)
 
end

function draw_grnd()
  rectfill(grnd.x, grnd.y, grnd.x+grnd.w, grnd.y + 2, 2)

end

-->8
--movement, gravity, etc


function p_mv()

--forces on the player

  p.dy+=p.gravity
  p.dx*=p.friction
  curr_y=p.y
  curr_x=p.x
  
  
--johnbo: spreading jump across frames
 if p.jumpframe > 0 then
   p.y-=p.boost / 5
   p.jumpframe-= 1
 end

--jump
  if p.jump then
    p.y+=p.gravity
  end


--player states
--landed
  if p.landed then
    p.jump=false
   
  end
  

--jump 
  if p.jump then
    p.landed=false
    p.y+=p.gravity
  end

--collision along ground
  if collide(p, grnd) then
     p.y=grnd.y - p.h - p.overlap
     p.landed=true 
  end

--inputs
 if btn(0) then p.dx-=p.acc end
 if btn(1) then p.dx+=p.acc end
 if btnp(4) and p.landed then
   p.jumpframe=5
   p.jump=true
   p.landed=false
 end

--p.x gets assigned dx
p.x+=p.dx



--wrap around screen
if p.x<0 then
  p.x=127
end
if p.x>127 then
  p.x=0
end



end--end of function
-->8
--collisions

function collide(a, b)

  local collide=false


  local ax=a.x
  local ay=a.y
  local aw=a.w
  local ah=a.h
  
  local bx=b.x
  local by=b.y
  local bw=b.w
  local bh=b.h
  
  local x_size=(aw * .5) + (bw * .5)
  local y_size=(ah * .5) + (bh * .5)
  
--measuring size and distance between and abs()'ing it  
  local x_distance=abs((ax + (aw / 2)) - (bx + (bw / 2)))  
  local y_distance=abs((ay + (ah / 2)) - (by + (bh / 2)))
--checking for collide
  if x_distance < x_size and y_distance < y_size then
    collide=true
  end
  
  if collide then
    p.overlap=a.y + a.h - b.y
  end
      
 
  return collide  
end
__gfx__
000000000a000a000a000a000a000a000a000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaa000aaaaa000aaaaa000aaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000aaaaa000aaaaa000aaaaa000aaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700004fcfc0004fcfc0004fcfc0004fcfc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700004ffff0004ffff0004ffff0004ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700002220000022200000222000002220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000f222f00002f200000222f00002f20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001010000001000000101000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000