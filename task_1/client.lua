local dvd={}
local imageMove= {}

function imageMove:new(t)
	local sx,sy=guiGetScreenSize() local cx,cy=sx/1366,sy/768
    local public= {
    	moveFactor=1,
    	red=255,
		green=255,
		blue=255,
		minX=t.x,
		minY=t.y,
		maxX=t.x+cx*200,
		maxY=t.y+cx*100,
		vy=math.random(2,8),
		minMoveX=t.minMoveX,
		maxMoveX=t.maxMoveX,
	}
	public.vx=10-public.vy

    function public:move()
    	local sx,sy=guiGetScreenSize() local x,y=sx/1366,sy/768
		self.minX=self.minX+self.vx
		self.minY=self.minY+self.vy
		self.maxX=self.minX+x*200
		self.maxY=self.minY+x*100
		if self.minX<self.minMoveX or self.maxX>self.maxMoveX then
			self.vx=-self.vx
			self:changeColour()
		end
		if self.minY<0 or self.maxY>sy then
			self.vy=-self.vy
			self:changeColour()
		end
	end

	function public:changeColour()
		self.red,self.green,self.blue=math.random(0,255),math.random(0,255),math.random(0,255)
		if (self.red+self.green+self.blue)<30 then -- защита чтобы новый цвет не слишком совпадал с тёмным фоном
			self.red=70
		end
	end

	function public:render(slice)
		local sx,sy=guiGetScreenSize() local x,y=sx/1366,sy/768
	    dxDrawImage(self.minX, self.minY, x*200, y* 100, "dvd.png", 0, 0, 0, tocolor(self.red,self.green,self.blue, 255), true)
		self:move()
	end

    setmetatable(public, self)
    self.__index = self
    return public
end

addEventHandler('onClientResourceStart',resourceRoot,function()
	local sx,sy=guiGetScreenSize() local x,y=sx/1366,sy/768
	local t={
		{x=x*sx/4-x*100,y=y*sy/2-y*50,minMoveX=0,maxMoveX=sx/2},
		{x=x*sx/4+x*sx/2-x*100,y=y*sy/2-y*50,minMoveX=sx/2,maxMoveX=sx},
	}
	for i=1,#t do
		--dvd[i] = imageMove:new(t[i].x,t[i].y,t[i].minMoveX,t[i].maxMoveX)
		dvd[i] = imageMove:new(t[i])
	end

	addEventHandler('onClientPreRender',root,function(slice)
		local sx,sy=guiGetScreenSize() local x,y=sx/1366,sy/768
		dxDrawRectangle(0,0, sx, sy, tocolor(0, 0, 0, 255), true)
		for i,v in pairs(dvd) do
			v:render(slice)
		end
	end)
end)