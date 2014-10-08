require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'pureftpd::user', :type => :define do

  let(:title) { 'username42' }
  let(:node) { 'rspec.example42.com' }
  let(:params) { {
    :password => 'password42',
    :uid      => '42',
    :gid      => '4242',
  } }


  describe 'Creation with MySQL backend' do
    let(:facts) { {
      :pureftpd_storage => 'mysql',
    } }

    it { should contain_mysql__query('pureftpd-create-user-username42').with_mysql_db('pureftpd') }
    it { should contain_mysql__query('pureftpd-create-user-username42').with_mysql_query(/INSERT INTO `ftpd`/) }
    it { should contain_mysql__query('pureftpd-create-user-username42').with_mysql_query(/\('username42', '1', MD5\('password42'\), '42', '4242', '\/home\/username42'/) }
  end


end

