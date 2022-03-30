do_mash = nil

function p_health_addr()
	local val = 0x0201D318
	val = memory.read_u32_le(val)
	val = memory.read_u32_le(val)
	val = val + 0x2C
	return val
end

function enem_health_addr()
	local val = 0x0201859C
	val = memory.read_u32_le(val)
	val = val + 0x88
	val = memory.read_u32_le(val)
	val = memory.read_u32_le(val)
	val = val + 0x2C
	memory.write_s32_le(val, 0)
end

function mash_text()
	local is_textbox = (memory.read_u8(0x02005C00) == 1) and not(memory.read_u32_le(0x0201B7A4) == 0)
	--local is_choice = memory.read_u8(0x0201AB2C) == 2
	local is_choice = nil
	if (is_textbox and not is_choice) then
		local buttons = joypad.get()
		if (buttons["A"]) then
			buttons["A"] = nil
			buttons["L"] = true
		else
			buttons["A"] = true
			buttons["L"] = nil
		end
		joypad.set(buttons)
	end
end

function input_check_handle()
	local table = input.get()
	if (table["P"])
	then
		enem_health_addr()
	end
	if (table["E"])
	then
		local addr = 0x0200C492
		local val = memory.read_u8(addr)
		val = val + ((val + 1) % 2)
		memory.write_u8(addr, val)
	end
	if (table["R"])
	then
		local addr = 0x0200C493
		memory.write_u8(addr, 0x10)
	end
	if (table["O"]) then
		do_mash = true
	end
	if (table["I"]) then
		do_mash = nil
	end
	if (do_mash == true) then
		mash_text()
	end
end

event.oninputpoll(input_check_handle)
while true do
	emu.frameadvance()
end