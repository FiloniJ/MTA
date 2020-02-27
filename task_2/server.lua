	db = dbConnect( "mysql", "dbname=acc;host=localhost;charset=utf8", "root", "")

	addEvent('addAccount',true)
	addEventHandler('addAccount',root,function(fname,lname,address)
		local r=dbPoll(dbQuery(db,"SELECT * FROM acc WHERE FName=? AND LName=?",fname,lname),-1)
		if r and #r>0 then
			drt(client,'Аккаунт с таким именем и фамилией уже существует!',2)
		else
			dbExec(db,"INSERT INTO acc(FName,LName,address) VALUES(?,?,?)",fname,lname,address)
			drt(client,'Вы успешно доабвили новый аккаунт.',3)
			triggerClientEvent(client,'isAccAdded',client,fname,lname,address)
		end
	end)

	addEvent('editAccount',true)
	addEventHandler('editAccount',root,function(fname,lname,address,t)
		local bool = dbExec(db,"UPDATE acc SET FName=?, LName=?, address=? WHERE FName=? AND LName=?",fname,lname,address,t[1],t[2])
		if bool then
			drt(client,'Вы успешно изменили данные аккаунта.',3)
		else
			drt(client,'Ошибка при попытке изменить данные аккаунта!',2)
		end
	end)

	addEvent('deleteAccount',true)
	addEventHandler('deleteAccount',root,function(fname,lname)
		local bool = dbExec(db,"DELETE FROM acc WHERE FName=? AND LName=?",fname,lname)
		if bool then
			drt(client,'Вы успешно удалили аккаунт.',3)
		else
			drt(client,'Ошибка удаления аккаунта!',2)
		end
	end)

	addEvent('getAllAccounts',true)
	addEventHandler('getAllAccounts',root,function()
		local r=dbPoll(dbQuery(db,"SELECT * FROM acc"),-1)
		triggerClientEvent(client,'allAccounts',client,r)
	end)

	function drt(el,str,t,r,g,b)
		triggerClientEvent(el,'drt',el,str,t,r,g,b) 
	end
