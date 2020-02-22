	local colour={
		dark={
			green = tocolor(0,150,0,255),
			red = tocolor(150,0,0,255),
			blue = tocolor(0,0,150,255),
		},
		ligth={
			green = tocolor(0,255,0,255),
			red = tocolor(255,0,0,255),
			blue = tocolor(0,0,255,255),
		},
		yellow = tocolor(255,255,0,255),
		gray = tocolor(128,128,128,255),
		brown = tocolor(204,102,0,255),
		black = tocolor(0,0,0,255),
		half = tocolor(0,0,0,128),
		full = tocolor(0,0,0,200),
		white = tocolor(255,255,255,255),
	}		
	
	local wm={}
	
	wm.initMenu = function(t)
		if isCursorShowing() then return end
		showCursor(true)
		wm.acc=t
		local sx,sy=guiGetScreenSize() local x,y=sx/1366,sy/768
		wm.menu = exports.dx:dxCreateWindow(x*203, y* 23, x*966, y* 669,'Редактирование аккаунтов',colour.full,colour.white,colour.dark.red,colour.dark.green)
		wm.gl = exports.dx:dxCreateGridList(x*1,0, x*964, y*516,wm.menu)
		exports.dx:dxGridListAddColumn(wm.gl,'Имя',0.3)
	  	exports.dx:dxGridListAddColumn(wm.gl,'Фамилия',0.3)
	  	exports.dx:dxGridListAddColumn(wm.gl,'Адрес',0.4)
	  	wm.page=0
	  	wm.maxPage=0
	  	wm.fillGrid = function()
	  		local maxRow=22
	  		local max=#wm.acc
			wm.maxPage=math.ceil(max/maxRow)-1
			if max>maxRow*(wm.page+1) then max=maxRow*(wm.page+1) end
			if max>#wm.acc then max=#wm.acc end
			exports.dx:dxGridClear(wm.gl)
			for i=wm.page*maxRow+1,max do
				local r=exports.dx:dxGridListAddRow(wm.gl)
			  	exports.dx:dxGridListSetItemText(wm.gl,r,1,wm.acc[i].FName)
			  	exports.dx:dxGridListSetItemText(wm.gl,r,2, wm.acc[i].LName)
			  	exports.dx:dxGridListSetItemText(wm.gl,r,3,wm.acc[i].address)
			end
	  	end
		if wm.acc then
			wm.fillGrid()
		end

		wm.glCheck = function()
			local r,c=exports.dx:dxGridListGetSelectedItem(wm.gl)
			if r~=wm.lastR then
				local keys={'firstName','lastName','address'}
				for i=1,#keys do
					exports.dx:dxSetText(wm[keys[i]],exports.dx:dxGridListGetItemText(wm.gl,r,i))
				end
				wm.lastR=r
			end
			showChat(false)
		end
		wm.lastR=0
		addEventHandler('onClientRender',root,wm.glCheck)

		wm.firstName = exports.dx:dxCreateEdit(x*5, y* 505, x*312, y* 35,'',wm.menu)
		wm.lastName = exports.dx:dxCreateEdit(x*325, y* 505, x*312, y* 35,'',wm.menu)
		wm.address = exports.dx:dxCreateEdit(x*642, y* 505, x*312, y* 35,'',wm.menu)

		wm.check = function()
			local fname = exports.dx:dxGetText(wm.firstName)
			local lname = exports.dx:dxGetText(wm.lastName)
			local address = exports.dx:dxGetText(wm.address)
			local var = {fname,lname,address}
			for i=1,#var do
				if #var[i]<2 then
					drt('Длина параметров должна быть выше 2 символов!',2)
					return false
				end
			end
			return fname,lname,address
		end

		wm.add = exports.dx:dxCreateImage(x*383, y* 543, x*50, y* 50,":v/Icons/add.png",wm.menu)
		addEventHandler('onClientDxClick',wm.add,function(bt,st)
			if st=='up' then return end
			local fname,lname,address = wm.check()
			if fname then
				triggerServerEvent('addAccount',localPlayer,fname,lname,address)
			end
		end,false)

		wm.edit = exports.dx:dxCreateImage(x*433, y* 543, x*50, y* 50,":v/Icons/edit.png",wm.menu)
		addEventHandler('onClientDxClick',wm.edit,function(bt,st)
			if st=='up' then return end
			local fname,lname,address = wm.check()
			if fname then
				local r,c=exports.dx:dxGridListGetSelectedItem(wm.gl)
				local t={}
				for i=1,2 do
					table.insert(t,exports.dx:dxGridListGetItemText(wm.gl,r,i))
				end
				triggerServerEvent('editAccount',localPlayer,fname,lname,address,t)
				for i=1,#wm.acc do
					if wm.acc[i].FName==t[1] and wm.acc[i].LName==t[2] then
						wm.acc[i].FName,wm.acc[i].LName,wm.acc[i].address=fname,lname,address
						break
					end
				end
				wm.fillGrid()
			end
		end,false)

		wm.search = exports.dx:dxCreateImage(x*483, y* 543, x*50, y* 50,":v/Icons/search.png",wm.menu)
		addEventHandler('onClientDxClick',wm.search,function(bt,st)
			if st=='up' then return end
			local fname = exports.dx:dxGetText(wm.firstName)
			local lname = exports.dx:dxGetText(wm.lastName)
			local address = exports.dx:dxGetText(wm.address)
			local t={}
			local var = {fname,lname,address}
			local key = {'FName','LName','address'}
			local t={}
			for k=1,#wm.acc do
				local shouldAdd = true
				for g=1,3 do
					if #var[g]>0 then
						if not wm.acc[k][key[g]]:find(var[g]) then
							shouldAdd = false
							break
						end
					end
				end
				if shouldAdd then
					table.insert(t,k)
				end
			end
			exports.dx:dxGridClear(wm.gl)
			if #t>0 then
				for i=1,#t do
					local r=exports.dx:dxGridListAddRow(wm.gl)
					for k=1,#key do
						exports.dx:dxGridListSetItemText(wm.gl,r,k,wm.acc[t[i]][key[k]])
					end
				end
			else
				for i=1,#var do
					if #var[i]~=0 then
						return
					end
				end
				wm.fillGrid()
			end
		end,false)

		wm.delete = exports.dx:dxCreateImage(x*533, y* 543, x*50, y* 50,":v/Icons/delete.png",wm.menu)
		addEventHandler('onClientDxClick',wm.delete,function(bt,st)
			if st=='up' then return end
			local r,c=exports.dx:dxGridListGetSelectedItem(wm.gl)
			if r>-1 then
				exports.dx:dxSetVisible(wm.menu,false)
				exports.dx:dxSetVisible(wm.warnBack,true)
			else
				drt('Выберите аккаунт из списка для удаления!',2)
			end
		end,false)

		wm.first=exports.dx:dxCreateButton(x*283, y* 545, x*50, y* 50,'<<',wm.menu,colour.black,colour.full,colour.white,colour.ligth.red,colour.white,colour.dark.red)
		wm.small=exports.dx:dxCreateButton(x*333, y* 545, x*50, y* 50,'<',wm.menu,colour.black,colour.full,colour.white,colour.ligth.red,colour.white,colour.dark.red)
		wm.high=exports.dx:dxCreateButton(x*583, y* 545, x*50, y* 50,'>',wm.menu,colour.black,colour.full,colour.white,colour.ligth.red,colour.white,colour.dark.red)
		wm.last=exports.dx:dxCreateButton(x*633, y* 545, x*50, y* 50,'>>',wm.menu,colour.black,colour.full,colour.white,colour.ligth.red,colour.white,colour.dark.red)
		
		wm.changePage = function(bt,st)
			if st=='up' then return end
			local i=this:getData('i')
			if i==1 then
				wm.page=0
			elseif i==2 then
				if wm.page>0 then
					wm.page=wm.page-1
				end
			elseif i==3 then
				if wm.page<wm.maxPage then
					wm.page=wm.page+1
				end
			elseif i==4 then
				wm.page=wm.maxPage
			end
			wm.fillGrid()
		end

		local keys={'first','small','high','last'}
		for i=1,#keys do
			wm[keys[i]]:setData('i',i,false)
			addEventHandler('onClientDxClick',wm[keys[i]],wm.changePage,false)
		end
		wm.close=exports.dx:dxCreateButton(x*383, y* 599, x*200, y* 30,'Закрыть',wm.menu,colour.black,colour.full,colour.white,colour.ligth.red,colour.white,colour.dark.red)
		addEventHandler('onClientDxClick',wm.close,function(bt,st)
			if st=='up' then return end
			removeEventHandler('onClientRender',root,wm.glCheck)
			exports.dx:destroy()
			showCursor(false)
			showChat(true)
			removeEventHandler('onClientCharacter',root,wm.char)
			unbindKey('backspace','down',wm.deleteFunc)
			wm.isBinded = false
		end,false)
		wm.editElement = false
		wm.isBinded = false

		addEventHandler('onClientDxClick',root,function(bt,st)
			if st=='up' then return end
			if source.type=='dxEdit' then
				if not wm.isBinded then
					addEventHandler('onClientCharacter',root,wm.char)
					bindKey('backspace','down',wm.deleteFunc)
					wm.isBinded = true
				end
				wm.editElement=source
			elseif wm.isBinded then
				wm.editElement = false
				removeEventHandler('onClientCharacter',root,wm.char)
				unbindKey('backspace','down',wm.deleteFunc)
				wm.isBinded = false
			end
		end)

		wm.char = function (symbol)
			if not isChatBoxInputActive() then
				local old = exports.dx:dxGetText(wm.editElement)
				exports.dx:dxSetText(wm.editElement,old..symbol)
			end
		end

		wm.deleteFunc = function()
			local old = exports.dx:dxGetText(wm.editElement)
			if #old>0 then
				exports.dx:dxSetText(wm.editElement,old:sub(1,#old-1))
			end
		end

		wm.warnBack = exports.dx:dxCreateWindow(x*468, y* 306, x*437, y* 208, "")
		wm.label = exports.dx:dxCreateLabel(x*6, y* 21, x*421, y* 77, "Вы уверены что хотите удалить данный аккунт? Данное действие невозвратимо!",wm.warnBack)
		wm.yes = exports.dx:dxCreateButton(x*79, y* 115, x*126, y* 55, "Удалить",wm.warnBack)
		addEventHandler('onClientDxClick',wm.yes,function(bt,st)
			if st=='up' then return end
			exports.dx:dxSetVisible(wm.menu,true)
			exports.dx:dxSetVisible(wm.warnBack,false)
			local r,c=exports.dx:dxGridListGetSelectedItem(wm.gl)
			local fname,lname=exports.dx:dxGridListGetItemText(wm.gl,r,1),exports.dx:dxGridListGetItemText(wm.gl,r,2)
			triggerServerEvent('deleteAccount',localPlayer,fname,lname)
			for i=1,#wm.acc do
				if wm.acc[i].FName==fname and wm.acc[i].LName==lname then
					table.remove(wm.acc,i)
					break
				end
			end
			wm.fillGrid()
		end,false)
		wm.no = exports.dx:dxCreateButton(x*254, y* 115, x*126, y* 55, "Оставить",wm.warnBack)
		addEventHandler('onClientDxClick',wm.no,function(bt,st)
			if st=='up' then return end
			exports.dx:dxSetVisible(wm.menu,true)
			exports.dx:dxSetVisible(wm.warnBack,false)
		end,false)
		exports.dx:dxSetVisible(wm.warnBack,false)
	end

	addCommandHandler('acc',function()
		triggerServerEvent('getAllAccounts',localPlayer)
	end)
	
	addEvent('allAccounts',true)
	addEventHandler('allAccounts',root,wm.initMenu)

	addEvent('isAccAdded',true)
	addEventHandler('isAccAdded',root,function(fname,lname,address)
		table.insert(wm.acc,{FName=fname,LName=lname,address=address})
		wm.fillGrid()
	end)
	
  	
  	
  	--// dx Сообщения
	local text = ""
	local text2 = ""
	local dupX=1
	local messages =  { }
	local r,g,b = 255,255,255
	local allTicks=0
	local lastTick=getTickCount()

	function outputTopBarMessage( cmd, red, green, blue, ... )
		local arg = {...}
		local message = table.concat( arg, " " )
		text = message
		r = red
		g = green
		b = blue
	end

	local timer = nil
	local tc={
		{255,255,255},
		{200,50,50},
		{50,200,50},
	}

	function drt( message,type, red, green, blue )
		text = message
		if not type or type>3 then type=1 end
		if not red and not type then
			r = 255
			g = 255
			b = 255
		else
			r=red or tc[type][1]
			g=green or tc[type][2]
			b=blue or tc[type][3]
		end
		local k=2
		if type~=2 then k=1 end
		local tick=getTickCount()
		if ( text ~= text2 and text ~= "" ) then
			local tim=string.len(text)*100
			if tim<2000 then tim=2000 end
			allTicks=allTicks+tim
			table.insert ( messages, { text, true, tick + tim, 180, r, g, b } )
			dupX=1
		else
			local tim=string.len(text)*100
			if tim<2000 then tim=2000 end
			allTicks=allTicks+tim
			dupX=dupX+1
			local i=#messages
			if i==0 then i=1 dupX=1 end
			messages[i]={text..'  [x'..dupX..']', true, tick + tim, 180, r, g, b}
		end
		text2 = text
		outputConsole(text)
	end
	addEvent( "drt", true )
	addEventHandler( "drt",root, drt )

	addEventHandler ( "onClientRender", root, function ( )
		local tick = getTickCount ( )
		allTicks=tick-lastTick
		lastTick=tick
		local sx,sy = guiGetScreenSize ( )
		if ( #messages > 7 ) then
			table.remove ( messages, 1 )
		end
		
		for index, data in ipairs ( messages ) do
			local v1 = data[1]
			local v2 = data[2]
			local v3 = data[3]
			local v4 = data[4]
			local v5 = data[5]
			local v6 = data[6]
			local v7 = data[7]
			dxDrawRectangle ( 0, (index-1)*25, sx, 25, tocolor( 0, 0, 0, v4 ),true)
			dxDrawText ( v1, 0, (index-1)*25, sx, index*25, tocolor( v5, v6, v7, v4+75 ), 0.75, "bankgothic", "center", "center",false,false,true)
			if tick >= v3 and index==1 then
				messages[index][4] = v4-2
				if ( v4 <= 25 ) then
					table.remove ( messages, index )
				end
			end
		end
	end,false,'low-99999' )







--[[
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
	    dxDrawImage(self.minX, self.minY, x*200, y* 100, ":v/dvd.png", 0, 0, 0, tocolor(self.red,self.green,self.blue, 255), true)
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
]]