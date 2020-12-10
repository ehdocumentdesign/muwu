module Muwu
  class ProjectOptionValidator


    include Muwu


    attr_reader(
      :key,
      :value
    )


    def initialize(key, value, project)
      key_validator = ProjectOptionValidatorKey.new(key, value, project)
      @key = key_validator.validated_key
      @value = key_validator.validated_value
    end



    protected


    def self.new_if_valid_key(key, value, project)
      option_validator = new(key, value, project)
      if option_validator.key
        return option_validator
      else
        return nil
      end
    end



  end
end
