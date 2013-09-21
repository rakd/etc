package "mysql-server" do
  action :install
end
 
service "mysqld" do
  action :start
end
