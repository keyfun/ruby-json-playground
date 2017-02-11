#!/usr/bin/ruby

require 'json'

class FieldObject
	@name=''
	@type=''
	@classObject=''
	def initialize(name, type, classObject)
		@name = name
		@type = type
		@class = classObject
	end
end

class ClassObject
	@name=''
	@level=0
	@fields=[]
	def initialize(name, level)
		@name = name
		@level = level
	end

	def name
		# return the value
		@name
	end

	def level
		@level
	end

	def toString()
		puts "name = #@name"
		puts "level = #@level"
	end
end

def loopJson(json)
	json.each do |key, value|
		if value.is_a?(Hash)
			puts 'Class Name = ' + key

			cls = ClassObject.new(key, 0)
			$arr << cls
    		# loop json object
    		loopJson(value)
    	else
    		puts key + ' = ' + value.to_s + ', type = ' + value.class.to_s
    	end
	end
end

# define global class array
# cls = ClassObject.new('key', 0)
# p cls.name
# p cls.level
$arr = []

Dir.glob('json/*.json') do |file|
	puts file

	data = File.read(file).force_encoding("UTF-8")
	data.gsub!("\xEF\xBB\xBF".force_encoding("UTF-8"), '')
	json = JSON.parse(data)
	puts json

	loopJson(json)
end

$arr.each do |cls|
	cls.toString()
end
