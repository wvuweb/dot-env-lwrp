# Base Resource
actions :create

default_action :create if defined?(default_action)

# Name Space
attribute :base_name, :name_attribute => true, :kind_of => String, :required => false, :default => 'default'  #This is what is passed in slack_notifications "<name>" do.

# Parameters
attribute :user, kind_of: String, required: true, default: nil
attribute :group, kind_of: String, required: true, default: nil
attribute :shared_dir, kind_of: String, required: true, default: nil
attribute :app_env, kind_of: Hash, required: true, default: nil
attribute :recursive, kind_of: [ TrueClass, FalseClass ], required: true, default: true
# attr_accessor :exists  #This is a standard ruby accessor, use this to set flags for current state.
