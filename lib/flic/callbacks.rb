require 'flic'

require 'thread'

module Flic
  module Callbacks
    SEMAPHORE = Mutex.new

    private

    def define_callbacks(*callback_names)
      callback_names.each do |callback_name|
        semaphore_instance_variable = :"@#{callback_name}_callbacks_semaphore"
        callbacks_instance_variable = :"@#{callback_name}_callbacks"

        define_method :"#{callback_name}" do |*args, &callback|
          semaphore = SEMAPHORE.synchronize do
            instance_variable_get(semaphore_instance_variable) ||
                instance_variable_set(semaphore_instance_variable, Mutex.new)
          end

          semaphore.synchronize do
            callbacks = instance_variable_get(callbacks_instance_variable) ||
                instance_variable_set(callbacks_instance_variable, [])

            if callback
              callbacks << callback
            else
              callbacks.each { |callback| callback.call *args }
            end
          end
        end
      end
    end
  end
end