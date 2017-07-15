node['service'].each do |my_action, names|
  if ["start", "stop", "restart"].include?(my_action)
    names.each do |name|
      service name do
        action my_action
	timeout 120
      end
    end
  end
end
