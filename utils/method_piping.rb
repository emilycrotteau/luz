class Module
	# Creates methods in a class that sends all calls of method 'signal' to
	# calls to a method of the given target instance variable
	def pipe(signal, target, options={})
		options = {:method => signal}.merge(options)
		if options[:args]
			module_eval( "def #{signal}(&proc) instance_variable_get('@' + '#{target.to_s}').send('#{options[:method]}', #{options[:args]}, &proc) ; end", "__(METHOD PIPING)__", 1)
		elsif options[:no_args]
			module_eval( "def #{signal}(&proc) instance_variable_get('@' + '#{target.to_s}').send('#{options[:method]}', &proc) ; end", "__(METHOD PIPING)__", 1)
		else
			module_eval( "def #{signal}(*args, &proc) instance_variable_get('@' + '#{target.to_s}').send('#{options[:method]}', *args, &proc) ; end", "__(METHOD PIPING)__", 1)
		end
	end
end
