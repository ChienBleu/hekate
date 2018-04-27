local matrix = require "src/matrix"
local quads = require "src/quads"
local loader = require "src/loader"
local chunk = matrix.read_matrix("test", "chunk")

local draw = require "src/draw"
local actor = require "src/actor"



function love.load()
  --tilematrix = matrix.iter_matrix(chunk) -- TODO find out why this one cannot be loaded in love.load
  actorslist = actor.read_actors('dummy', 'actors')
end

function love.draw()
  -- Matrix test
  tilematrix = matrix.iter_matrix(chunk) -- placeholder while we figure out why it cannot be loaded in love.load
  draw.draw_matrix(tilematrix,loader.tileset,quads)
  love.graphics.print(love.timer.getFPS(), 10, 10)

  -- Actors test
  for i = 1, #actorslist do
    draw.draw_actor(actorslist[i],loader.sprite)
    draw.draw_actor_name(actorslist[i])
  end

end


-- Make the actor be drawn at each update, in case they have moved

-- Actor motion test : make each actor move  every second
dtotal = 0
function love.update(dt)
  dtotal = dtotal + dt
  if dtotal >= 1 then
    dtotal = dtotal - 1
    for i = 1, #actorslist do
      actor.move_actor(actorslist[i],1,1)
      love.draw()
    end
  end
end
