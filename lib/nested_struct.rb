require 'ostruct'
class NestedStruct < OpenStruct
  def initialize(hash=nil)
    super(hash)
    @sub_hash = {}
  end

  def new_ostruct_member(name)
    name = name.to_sym
    unless self.respond_to?(name)
      class << self; self; end.class_eval do
        define_method(name) do
          v = @table[name]
          if v.is_a?(Hash)
            @sub_hash[name] ||= NestedStruct.new(v)
          elsif v.is_a?(Array)
            @sub_hash[name] ||= access_from_array(v)
          else
            v
          end
        end
        define_method("#{name}=") { |x| modifiable[name] = x }
      end
    end
    name
  end

  def access_from_array(array)
    array.map do |item|
      if item.is_a? Hash
        NestedStruct.new(item)
      elsif item.is_a? Array
        access_from_array(item)
      else
        item
      end
    end
  end
end
