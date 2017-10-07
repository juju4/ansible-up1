require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

up1_reverseport = 1443

describe package('httpd'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe port("#{up1_reverseport}") do
  it { should be_listening }
end

describe command("curl --resolve 'up1.example.com:#{up1_reverseport}:localhost' -kvL https://up1.example.com:#{up1_reverseport}"), :if => os[:family] == 'ubuntu' do
  its(:stdout) { should match /<title>Up1<\/title>/ }
  its(:stdout) { should match /The client side cryptography of this application requires that Javascript be enabled to view and upload files./ }
  its(:stdout) { should match /Source Code/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/i }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:exit_status) { should eq 0 }
end
## centos7: fail above 'NSS error -5938 (PR_END_OF_FILE_ERROR)', success below
describe command("curl --tlsv1.2 --resolve 'up1.example.com:#{up1_reverseport}:localhost' -kvL https://up1.example.com:#{up1_reverseport}") do
  its(:stdout) { should match /<title>Up1<\/title>/ }
  its(:stdout) { should match /The client side cryptography of this application requires that Javascript be enabled to view and upload files./ }
  its(:stdout) { should match /Source Code/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/i }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:exit_status) { should eq 0 }
end
