Slib = require "slib"

numTable = {}
N, M = 100, 100

function generateNumbers()
  for i=1, N do
    numTable[i]={}
    for j=1, M do
      numTable[i][j]=math.random(0, 1)
    end
  end 
end

function love.load()
  Slib.init("Slib")
    
  if Slib.isFirstSave(save) then --if there is no save
    generateNumbers()
  else --if there is save file
    numTable = Slib.load() 
  end
end

function love.update(dt)
  if love.keyboard.isDown('g') then  
    generateNumbers()
  end
end

function love.quit()
  Slib.saveE(numTable) --save stats (ENCRYPT!!)   
end

function love.draw()
  love.graphics.print("Num of elements: 10000", 10, 10)
  love.graphics.print("'G' to Generate, on exit it saves, and load last variant", 200, 10)
  
  for i=1, N do
    for j=1, M do
      love.graphics.print(numTable[i][j], 10+(i*10), 30+(j*10))
    end
  end 
end