action :create do
  directory "#{new_resource.shared_dir}" do
    recursive new_resource.recursive
    user new_resource.user
    group new_resource.group
    path "#{new_resource.shared_dir}"
    action :create
    only_if { !::File.directory?("#{new_resource.shared_dir}") }
  end

  template "#{new_resource.shared_dir}/.env" do
    cookbook 'dot-env-lwrp'
    source "env.erb"
    owner new_resource.user
    group new_resource.group
    mode "0660"
    variables({
      :env => new_resource.app_env
    })
  end

  Chef::Log.info(".env file should now exist at: #{new_resource.shared_dir}.env")
end


# Override Load Current Resource
def load_current_resource

  @current_resource = Chef::Resource::DotEnvLwrp.new(@new_resource.name)
  #dot-env-lwrp is the name of my cookbook.  chef will convert the name to a class so it becomes DotEnvLwrp.  This is because there is a '-'
  #If I were to create something other than default, say service.rb in my provider/resource.  This would then be DotEnvLwrpService.new and you
  #would access it in your recipes with dot_env_lwrp_service.

  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.user(@new_resource.user)  #DSL converts our parameters/attrbutes to methods to get and set the instance variable inside the Provider and Resource.
  @current_resource.group(@new_resource.group)
  @current_resource.shared_dir(@new_resource.shared_dir)
  @current_resource.app_env(@new_resource.app_env)
  @current_resource.recursive(@new_resource.recursive)

  #Get current state
  # @current_resource.exists = ::File.file?("/var/#{ @new_resource.name }")

end
