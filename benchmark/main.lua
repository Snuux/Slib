Slib = require "slib"
function love.load()
  
  g = {} --player
  time = {} --time (for benchmark)
  
  time.save = 0 --for init times
  time.saveE = 0
  time.load = 0
  
  angle = 0 --angle for image rotation
  
  save = "supersave.pass" --save file name
  encription = {43,76,43,87,43} --encryption key
  
  Slib.init("Slib")
  
  if Slib.isFirstSave(save) then --if there is no save
    
    g.stats = {} --char stats
    for i=1, 100 do
      g.stats[i]={}
      for j=1, 100 do
        g.stats[i][j]=i*j
      end
    end 
    
  else --if there is save file
    g.stats = Slib.load(save, encription) 
  end
  
  g.res = {}
  g.res.tile = love.graphics.newImage("res/img/tile.png") --it's image (BE CAREFUL!) Slib can't save images! (But can save names of them)
end

function love.update(dt)
  if love.keyboard.isDown('s') then  
    
    local startTime = os.clock()
    Slib.save(g.stats, save, nil, encription) --save stats (Don't ENCRYPT)
    local endTime = os.clock()
    time.save = endTime - startTime
    
  end
  if love.keyboard.isDown('e') then
    
    local startTime = os.clock()
    Slib.saveE(g.stats, save, nil, encription) --save stats (ENCRYPT!!)
    local endTime = os.clock()
    time.saveE = endTime - startTime
    
  end
  if love.keyboard.isDown('l') then
    
    local startTime = os.clock()
    g.stats = Slib.load(save, encription) --load stats!
    local endTime = os.clock()
    time.load = endTime - startTime
    
  end
  
  angle = angle + 1
end

function love.draw()
  --draw our time:
  love.graphics.print("Num of elements: 10000", 10, 10)
  love.graphics.print("Save: " .. time.save .. " Encript: " .. time.saveE .. " Load: " .. time.load, 10, 30)
  
  love.graphics.print("'S' to Save, 'E' to Encript, 'L' to Load", 10, 50)
  
  --draw image
  love.graphics.draw(g.res.tile, 100, 135, math.rad(angle), 1, 1, 96/2, 16/2)
end