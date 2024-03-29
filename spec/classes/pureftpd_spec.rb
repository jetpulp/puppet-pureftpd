require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'pureftpd' do

  let(:title) { 'pureftpd' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test standard installation' do
    it { should contain_package('pureftpd').with_ensure('present') }
    it { should contain_service('pureftpd').with_ensure('running') }
    it { should contain_service('pureftpd').with_enable('true') }
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('pureftpd').with_ensure('1.0.42') }
  end

  describe 'Test standard installation with monitoring and firewalling' do
    let(:params) { {:monitor => true , :firewall => true, :port => '42', :protocol => 'tcp' } }
    it { should contain_package('pureftpd').with_ensure('present') }
    it { should contain_service('pureftpd').with_ensure('running') }
    it { should contain_service('pureftpd').with_enable('true') }
    it { should contain_monitor__process('pureftpd_process').with_enable('true') }
    it { should contain_monitor__port('pureftpd_tcp_42').with_port('42') }
    it { should contain_monitor__port('pureftpd_tcp_42').with_protocol('tcp') }
    it { should contain_firewall('pureftpd_tcp_42').with_enable('true') }
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
    it 'should remove Package[pureftpd]' do should contain_package('pureftpd').with_ensure('absent') end
    it 'should stop Service[pureftpd]' do should contain_service('pureftpd').with_ensure('stopped') end
    it 'should not enable at boot Service[pureftpd]' do should contain_service('pureftpd').with_enable('false') end
    it { should contain_monitor__process('pureftpd_process').with_enable('false') }
    it { should contain_firewall('pureftpd_tcp_42').with_enable('false') }
  end

  describe 'Test decommissioning - disable' do
    let(:params) { {:disable => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
    it { should contain_package('pureftpd').with_ensure('present') }
    it 'should stop Service[pureftpd]' do should contain_service('pureftpd').with_ensure('stopped') end
    it 'should not enable at boot Service[pureftpd]' do should contain_service('pureftpd').with_enable('false') end
    it { should contain_monitor__process('pureftpd_process').with_enable('false') }
    it { should contain_firewall('pureftpd_tcp_42').with_enable('false') }
  end

  describe 'Test decommissioning - disableboot' do
    let(:params) { {:disableboot => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
    it { should contain_package('pureftpd').with_ensure('present') }
    it { should_not contain_service('pureftpd').with_ensure('present') }
    it { should_not contain_service('pureftpd').with_ensure('absent') }
    it 'should not enable at boot Service[pureftpd]' do should contain_service('pureftpd').with_enable('false') end
    it { should contain_monitor__process('pureftpd_process').with_enable('false') }
    it { should contain_firewall('pureftpd_tcp_42').with_enable('true') }
  end

  describe 'Test noops mode' do
    let(:params) { {:noops => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
    it { should contain_package('pureftpd').with_noop('true') }
    it { should contain_service('pureftpd').with_noop('true') }
    it { should contain_monitor__process('pureftpd_process').with_noop('true') }
    it { should contain_monitor__process('pureftpd_process').with_noop('true') }
    it { should contain_monitor__port('pureftpd_tcp_42').with_noop('true') }
    it { should contain_firewall('pureftpd_tcp_42').with_noop('true') }
  end

  describe 'Test customizations - source_dir' do
    let(:params) { {:source_dir => "puppet:///modules/pureftpd/dir/spec" , :source_dir_purge => true } }
    it { should contain_file('pureftpd.dir').with_source('puppet:///modules/pureftpd/dir/spec') }
    it { should contain_file('pureftpd.dir').with_purge('true') }
    it { should contain_file('pureftpd.dir').with_force('true') }
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "pureftpd::spec" } }
    it { should contain_service('pureftpd').with_hasrestart(/true/) }
  end

  describe 'Test service autorestart' do
    let(:params) { {
      :service_autorestart => "no",
      :storage             => 'mysql',

    } }
    it 'should not automatically restart the service, when service_autorestart => false' do
      should contain_file('pureftpd-mysql.conf').with_notify(nil)
    end
  end

  describe 'Test Puppi Integration' do
    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }
    it { should contain_puppi__ze('pureftpd').with_helper('myhelper') }
  end

  describe 'Test Monitoring Tools Integration' do
    let(:params) { {:monitor => true, :monitor_tool => "puppi" } }
    it { should contain_monitor__process('pureftpd_process').with_tool('puppi') }
  end

  describe 'Test Firewall Tools Integration' do
    let(:params) { {:firewall => true, :firewall_tool => "iptables" , :protocol => "tcp" , :port => "42" } }
    it { should contain_firewall('pureftpd_tcp_42').with_tool('iptables') }
  end

  describe 'Test OldGen Module Set Integration' do
    let(:params) { {:monitor => "yes" , :monitor_tool => "puppi" , :firewall => "yes" , :firewall_tool => "iptables" , :puppi => "yes" , :port => "42" , :protocol => 'tcp' } }
    it { should contain_monitor__process('pureftpd_process').with_tool('puppi') }
    it { should contain_firewall('pureftpd_tcp_42').with_tool('iptables') }
    it { should contain_puppi__ze('pureftpd').with_ensure('present') }
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => true , :ipaddress => '10.42.42.42' } }
    let(:params) { { :port => '42' } }
    it 'should honour top scope global vars' do should contain_monitor__process('pureftpd_process').with_enable('true') end
  end

  describe 'Test params lookup' do
    let(:facts) { { :pureftpd_monitor => true , :ipaddress => '10.42.42.42' } }
    let(:params) { { :port => '42' } }
    it 'should honour module specific vars' do should contain_monitor__process('pureftpd_process').with_enable('true') end
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => false , :pureftpd_monitor => true , :ipaddress => '10.42.42.42' } }
    let(:params) { { :port => '42' } }
    it 'should honour top scope module specific over global vars' do should contain_monitor__process('pureftpd_process').with_enable('true') end
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => false , :ipaddress => '10.42.42.42' } }
    let(:params) { { :monitor => true , :firewall => true, :port => '42' } }
    it 'should honour passed params over global vars' do should contain_monitor__process('pureftpd_process').with_enable('true') end
  end

  describe 'Test storage selection' do
    let(:facts) { { :operatingsystem        => 'Debian' } }
    let(:params) { { :storage => 'mysql' } }
    it { should contain_package('pureftpd').with_ensure('present') }
    it { should contain_package('pureftpd').with_name('pure-ftpd-mysql') }
    it { should_not contain_package('pure-ftpd').with_ensure('present') }
    # MySQL GRANT
    it { should contain_mysql__grant('pureftpd').with_mysql_user('pureftpd') }
    it { should contain_mysql__grant('pureftpd').with_mysql_db('pureftpd') }
    # MySQL CREATE TABLE
    it { should contain_mysql__query('pureftpd-create-table').with_mysql_db('pureftpd') }
    it { should contain_mysql__query('pureftpd-create-table').with_mysql_query(/CREATE TABLE ftpd/) }
    # remove unix binding
    it { should contain_file('/etc/pure-ftpd/db/65unix').with_ensure('absent') }
  end

  describe 'Test debug' do
    let(:params) { { :debug => true } }
    it { should contain_file('debug_pureftpd').with_ensure('present') }
  end

end

