actions :create
default_action :create

attribute :name, :kind_of => String
attribute :extract_to, :kind_of => String, default: "Chef::Config['file_cache_path']"
