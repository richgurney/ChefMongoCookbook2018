require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package ('mongodb-org') do
  it { should be_installed }
end

describe service ('mongod') do 
  it { should be_running }
  it { should be_enabled }
end

describe port(27017) do
  it { should be_listening }
end