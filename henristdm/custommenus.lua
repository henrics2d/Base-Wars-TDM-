sme = {}
sme.pending = {}

-- id = the id of the player to create the menu for
-- func = the callback function
-- buttonProcessor = the callback function to process each value
-- title = the title for the menu
-- nextPrev = if true, will add next and prev buttons
-- buttons = a table (number index) with each button
-- [OPTINAL] big = if true, will make a big menu
-- [OPTINAL] parameter = some extra data, if you wanna send with, remember that tables are referenced by pointers, deep copy might be required
function sme.createMenu(id,func,buttonProcessor,title,nextPrev,buttons,big,parameter)
	local temp = {}
	temp.func = func
	temp.buttonProcessor = buttonProcessor
	temp.title = title
	temp.nextPrev = nextPrev
	temp.buttons = buttons
    temp.big = big
	temp.page = 0
	temp.parameter = parameter
	sme.pending[id] = temp
	sme.open(id)
end

function sme.open(id)
    parameter = sme.pending[id].parameter
	local menu_data = sme.pending[id].title
    if sme.pending[id].big then
        menu_data = menu_data.."@b"
    end
	if sme.pending[id].nextPrev then
		if sme.pending[id].page > 0 then
			menu_data = menu_data..",Previous"
		else
			menu_data = menu_data..",(Previous)"
		end
		local count = (sme.pending[id].page*7)--(sme.pending[id].page)
		local i = count
		while (i < count+7) do
			i = i + 1
			if (sme.pending[id] == nil) == false then
				if sme.pending[id].buttons[i] == nil then
					menu_data = menu_data..","
				else
					menu_data = menu_data..","..sme.pending[id].buttonProcessor(id,sme.pending[id].buttons[i],parameter)
				end
			end
		end
		if (sme.pending[id].page+1)*7 < #sme.pending[id].buttons then
			menu_data = menu_data..",Next"
		else
			menu_data = menu_data..",(Next)"
		end
	else
		for i=1,#sme.pending[id].buttons do
			if not (sme.pending[id].buttons[i] == nil) then
				menu_data = menu_data..","..sme.pending[id].buttonProcessor(id,sme.pending[id].buttons[i],parameter)
			end
		end
	end
	menu(id,menu_data)
end

function sme.noProcess(id,text)
	return text
end

addhook("menu","sme.menu")
function sme.menu(id, title, button)
	if not (sme.pending[id] == nil) then
		if sme.pending[id].nextPrev then
			if button == 0 then
				return false
			end
			if button == 1 then
				sme.pending[id].page = sme.pending[id].page - 1
				sme.open(id)
				return 0
			end
			if button == 9 then
				sme.pending[id].page = sme.pending[id].page + 1
				sme.open(id)
				return 0
			end
            local real_button = ((sme.pending[id].page*7)+button-1)
            local data = sme.pending[id].buttons[real_button]
			sme.pending[id].func(id,real_button,data,sme.pending[id].parameter)
		else
            before = sme.pending[id]
            local data = sme.pending[id].buttons[button]
			sme.pending[id].func(id,button,data,sme.pending[id].parameter)
            if sme.pending[id] == before then
                sme.pending[id] = nil
            end
		end
	end
end
