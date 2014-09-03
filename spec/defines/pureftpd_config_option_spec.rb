require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'pureftpd::config_option', :type => :define do

  let(:title) { 'my_example42_params' }
  let(:node) { 'rspec.example42.com' }
  let(:params) { {
    :value => '42',
  } }


  describe 'Simple call' do
    it { should contain_file('pureftpd-config_option-my_example42_params').with_path('/etc/pure-ftd/conf/my_example42_params') }
    it { should contain_file('pureftpd-config_option-my_example42_params').with_content('42') }
  end

  describe 'Test config_name' do
    let(:params) { {
      :value       => '42',
      :config_name => 'other_params',
    } }

    it { should contain_file('pureftpd-config_option-my_example42_params').with_path('/etc/pure-ftd/conf/other_params') }
    it { should contain_file('pureftpd-config_option-my_example42_params').with_content('42') }
  end

end

