require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

up1_reverseport = 1443

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port("#{up1_reverseport}") do
  it { should be_listening }
end

## centos7 fail: TCP connection reset by peer
describe command("curl --resolve 'up1.example.com:#{up1_reverseport}:localhost' -kvL https://up1.example.com:#{up1_reverseport}"), :if => os[:family] == 'ubuntu' do
  its(:stdout) { should match /<title>Up1<\/title>/ }
  its(:stdout) { should match /The client side cryptography of this application requires that Javascript be enabled to view and upload files./ }
  its(:stdout) { should match /Source Code/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/i }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:exit_status) { should eq 0 }
end
describe command("curl --tlsv1.2 --resolve 'up1.example.com:#{up1_reverseport}:localhost' -kvL https://up1.example.com:#{up1_reverseport}") do
  its(:stdout) { should match /<title>Up1<\/title>/ }
  its(:stdout) { should match /The client side cryptography of this application requires that Javascript be enabled to view and upload files./ }
  its(:stdout) { should match /Source Code/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/i }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:exit_status) { should eq 0 }
end
