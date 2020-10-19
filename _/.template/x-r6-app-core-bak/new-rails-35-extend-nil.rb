# puts "STEP: Extend NilClass"
class NilClass
	def to_bool; false; end
end
