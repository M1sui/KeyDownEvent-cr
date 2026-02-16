# usage
# key=Key.new(debug: false)
# key.keyDown{|keyName,vid|
# 	puts keyName
# 	puts vid
# }
# 
# key.run

@[Link("user32")]
lib U32
	fun GetAsyncKeyState(vk : Int32) : Int16
	fun MapVirtualKeyW(code : UInt32,map : UInt32) : UInt32
	fun GetKeyNameTextW(lp : Int32,buf : UInt16*,sz : Int32) : Int32
end

@[Link("kernel32")]
lib K32
	fun Sleep(ms : UInt32)
end

class Key
	@debug : Bool
	@down : Proc(String,Int32,Nil)?

	@sc : UInt32=0u32
	@lp : Int32=0
	@ln : Int32=0
	@bf=StaticArray(UInt16,64).new(0u16)

	def initialize(debug : Bool=false)
		@debug=debug
	end

	def keyDown(&blk : String,Int32 -> Nil)
		@down=blk
	end

	def run
		loop{
			vk=0x08
			while vk<=0xFE
				tick(vk)
				vk+=1
			end
			K32.Sleep(10u32)
		}
	end

	private def tick(vk : Int32)
		fire(vk) if (U32.GetAsyncKeyState(vk) & 0x0001)!=0
	end

	private def fire(vk : Int32)
		@down.try &.call(name(vk),vk)
	end

	private def name(vk : Int32) : String
		@sc=U32.MapVirtualKeyW(vk.to_u32,0)
		@lp=(@sc << 16).to_i32
		@ln=U32.GetKeyNameTextW(@lp,@bf.to_unsafe,64)
		return "VK:#{vk}" if @ln<=0
		String.from_utf16(@bf.to_slice[0,@ln])
	end
end