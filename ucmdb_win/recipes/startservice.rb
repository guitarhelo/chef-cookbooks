service "UCMDB_Server" do
  action :start
end
sleep 360
service "UCMDB_Integration" do
  action :start
end
sleep 360
