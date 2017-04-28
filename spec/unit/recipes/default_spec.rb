#
# Cookbook:: node-server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mongo-server::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should update the key server for mongo' do
      expect(chef_run).to run_execute('apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927')
    end

    it 'should create a sources file' do
      expect(chef_run).to create_file('/etc/apt/sources.list.d/mongodb-org-3.2.list')
    end

    it 'should update the source for apt' do
      expect(chef_run).to update_apt_update 'update'
    end

    it 'should install mongod' do
      expect(chef_run).to install_package 'mongodb-org'
    end

    it 'should update the mongod config' do
      expect(chef_run).to create_template '/lib/systemd/system/mongod.service'
    end

    it 'should enable the mongod service' do
      expect(chef_run).to enable_service 'mongod'
    end

    it 'should start the mongod service' do
      expect(chef_run).to start_service 'mongod'
    end

  end
end
