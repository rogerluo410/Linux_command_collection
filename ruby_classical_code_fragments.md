unless attributes_collection.is_a?(Hash) || attributes_collection.is_a?(Array)
   raise ArgumentError, "Hash or Array expected, got #{attributes_collection.class.name} (#{attributes_collection.inspect})"
end
