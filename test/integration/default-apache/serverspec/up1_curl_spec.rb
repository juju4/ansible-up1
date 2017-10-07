require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

up1_port = 8080

describe port("#{up1_port}") do
  it { should be_listening }
end

describe command("curl -kvL http://localhost:#{up1_port}") do
  its(:stdout) { should match /<title>Up1<\/title>/ }
  its(:stdout) { should match /The client side cryptography of this application requires that Javascript be enabled to view and upload files./ }
  its(:stdout) { should match /Source Code/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/ }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:exit_status) { should eq 0 }
end
