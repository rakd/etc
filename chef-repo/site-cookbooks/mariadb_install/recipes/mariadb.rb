cookbook_file "/etc/yum.repos.d/mariadb.repo" do
  source "mariadb.repo"
  mode 00644
  owner "root"
  group "root"
end
 
%w{MariaDB-devel MariaDB-client MariaDB-server}.each do |marias|
  package marias do
    action :install
  end
end
 
service "mysql" do
  action :start
end
