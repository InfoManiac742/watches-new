function mash_yes()
	buttons = joypad.get()
	if (buttons["P1 A"]) then
		buttons["P1 A"] = nil
		buttons["P1 L"] = true
	else
		buttons["P1 A"] = true
		buttons["P1 L"] = nil
	end
	joypad.set(buttons)
end

function mash_no()
	buttons = joypad.get()
	if (buttons["P1 B"]) then
		buttons["P1 B"] = nil
		buttons["P1 Select"] = true
	else
		buttons["P1 B"] = true
		buttons["P1 Select"] = nil
	end
	joypad.set(buttons)
end


function input_check_handle()
	local table = input.get()
	local is_text = not(memory.read_u8(0x7E8958) == 0xFF)
	if (table["Q"] and is_text) then
		mash_yes()
	end
	if (table["W"] and is_text) then
		mash_no()
	end
end

while true do
	emu.frameadvance()
	input_check_handle()
end