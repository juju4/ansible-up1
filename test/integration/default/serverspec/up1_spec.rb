require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

up1_working_dir = "/var/www-up1/src"
up1_user = "www-up1"

describe package('nodejs'), :if => os[:family] == 'debian' || os[:family] == 'ubuntu' do
  it { should be_installed }
end
describe package('nodejs'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

## for whatever reason??? service and process check works only on centos7/lxd (not docker...)
#describe service('up1'), :if => os[:family] == 'redhat' do
#  it { should be_enabled }
#  it { should be_running }
#end
#describe process("node"), :if => os[:family] == 'redhat' do
#  its(:user) { should eq "#{up1_user}" }
#  its(:args) { should match /server.js/ }
#  it { should be_running }
#end

describe file("#{up1_working_dir}") do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by "#{up1_user}" }
end
describe file("#{up1_working_dir}/server/server.conf") do
  it { should be_file }
  it { should be_mode 644 }
#  it { should be_owned_by "#{up1_user}" }
  it { should be_owned_by "root" }
end
describe file("#{up1_working_dir}/client/config.js") do
  it { should be_file }
  it { should be_mode 644 }
#  it { should be_owned_by "#{up1_user}" }
  it { should be_owned_by "root" }
end

describe command("npm list") do
  let(:sudo_options) { '-u www-up1 -H' }
  let(:pre_command) { "cd #{up1_working_dir}/server" }
  its(:stdout) { should match /busboy/ }
  its(:stdout) { should match /request/ }
  its(:stderr) { should match "" }
  its(:exit_status) { should eq 0 }
end

describe command("npm outdated") do
  let(:sudo_options) { '-u www-up1 -H' }
  let(:pre_command) { "cd #{up1_working_dir}/server" }
  its(:stdout) { should match "" }
  its(:stderr) { should match "" }
  its(:exit_status) { should eq 0 }
end

#describe port(8080) do
#  it { should be_listening }
#end
